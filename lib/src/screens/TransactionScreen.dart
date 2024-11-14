import 'package:SenCash/src/routes/HomeRoute.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/UserModel.dart';
import '../providers/TransactionProvider.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/contact/ContactPickerField.dart'; // Votre champ personnalisé pour les montants

class TransactionScreen extends StatefulWidget {
  final UserModel? receiverData; // Utilisateur destinataire, optionnel

  const TransactionScreen({Key? key, this.receiverData}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _amountReceivedController = TextEditingController();
  final TextEditingController _searchController = TextEditingController(); // Contrôleur de recherche


  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Si receiverData est passé, on pré-remplit le champ avec le numéro de téléphone du destinataire
    if (widget.receiverData != null) {
      _receiverController.text = widget.receiverData!.numeroTelephone ?? '';
    }
  }

  void _syncAmounts({bool isSend = true}) {
    final amount = double.tryParse(isSend ? _amountController.text : _amountReceivedController.text);
    if (amount == null) return;

    if (isSend) {
      final received = amount - (amount * 0.01);
      _amountReceivedController.text = received.toStringAsFixed(2);
    } else {
      final send = amount / 0.99;
      _amountController.text = send.toStringAsFixed(2);
    }
  }

  Future<void> _performTransaction() async {
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    final receiverPhone = _receiverController.text;
    final amount = double.tryParse(_amountController.text);

    if (receiverPhone.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs correctement.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final success = await provider.sendMoney(
      receiverPhone: receiverPhone,
      amount: amount,
      description: "Transfert simple",
    );

    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Transfert effectué avec succès !")),
      );
      Navigator.pushReplacementNamed(context, HomeRoute.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Échec du transfert.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Transfert Simple")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _receiverController,
              label: "Téléphone du destinataire",
              prefixIcon: Icons.phone,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _amountController,
              label: "Montant à envoyer",
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.number,
              onChanged: (_) => _syncAmounts(isSend: true),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _amountReceivedController,
              label: "Montant reçu",
              prefixIcon: Icons.money,
              keyboardType: TextInputType.number,
              onChanged: (_) => _syncAmounts(isSend: false),
            ),
            const SizedBox(height: 16),
            ContactPickerField(
              controller: _receiverController,
              label: "Sélectionner un destinataire",
              searchController: _searchController, // Passer le searchController ici
              multipleSelection: false, // Mode simple
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isLoading ? null : _performTransaction,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Envoyer"),
            ),
          ],
        ),
      ),
    );
  }
}
