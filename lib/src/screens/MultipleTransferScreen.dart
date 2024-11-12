import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/TransactionProvider.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/contact/ContactPickerField.dart'; // Votre champ personnalisé pour les montants

class MultipleTransferScreen extends StatefulWidget {
  const MultipleTransferScreen({Key? key}) : super(key: key);

  @override
  State<MultipleTransferScreen> createState() => _MultipleTransferScreenState();
}

class _MultipleTransferScreenState extends State<MultipleTransferScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _amountReceivedController = TextEditingController();
  final TextEditingController _contactsController = TextEditingController();
  final TextEditingController _searchController = TextEditingController(); // Contrôleur de recherche


  bool _isLoading = false;

  List<String> _selectedContacts = [];

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

  Future<void> _performMultipleTransfer() async {
    if (_selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner des destinataires.")),
      );
      return;
    }

    final provider = Provider.of<TransactionProvider>(context, listen: false);
    final amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez saisir un montant valide.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    await provider.performMultipleTransfer(
      receiverPhone: _selectedContacts,
      amount: amount,
      description: "Transfert multiple",
    );

    setState(() => _isLoading = false);

    if (provider.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Transfert multiple réussi !")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : ${provider.error}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Transfert Multiple")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
              controller: _contactsController,
              label: "Sélectionnez des destinataires",
              multipleSelection: true, // Mode multiple
              searchController: _searchController, // Passer le searchController ici
              onContactsSelected: (List<String> contacts) {
                setState(() {
                  _selectedContacts = contacts;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: _selectedContacts
                    .map((contact) => ListTile(
                  title: Text(contact),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      setState(() {
                        _selectedContacts.remove(contact);
                      });
                    },
                  ),
                ))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _performMultipleTransfer,
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
