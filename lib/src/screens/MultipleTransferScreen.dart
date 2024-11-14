import 'package:SenCash/src/routes/TransactionRoute.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/TransactionProvider.dart';
import '../widgets/layout/CustomFooter.dart';
import '../widgets/layout/WaveHeader.dart';
import '../widgets/transactions/multiple/MultipleTransferForm.dart';


class MultipleTransferScreen extends StatefulWidget {
  const MultipleTransferScreen({Key? key}) : super(key: key);

  @override
  State<MultipleTransferScreen> createState() => _MultipleTransferScreenState();
}

class _MultipleTransferScreenState extends State<MultipleTransferScreen> {
  bool _isLoading = false;

  Future<void> _performMultipleTransfer(double amount, List<String> selectedContacts) async {
    final provider = Provider.of<TransactionProvider>(context, listen: false);

    setState(() => _isLoading = true);

    await provider.performMultipleTransfer(
      receiverPhone: selectedContacts,
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
      body: Column(
        children: [
          // Ajout du WaveHeader
          const WaveHeader(
            title: "Transfert Multiple",
            subtitle: "Envoyez de l'argent à plusieurs contacts",
            showBackButton: true,
          ),

          // Contenu principal de l'écran
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: MultipleTransferForm(
                onTransfer: (amount, selectedContacts) {
                  _performMultipleTransfer(amount, selectedContacts);
                },
              ),
            ),
          ),
        ],
      ),

      // Ajout du CustomFooter
      bottomNavigationBar: const CustomFooter(
        currentRoute: TransactionRoute.multiple, // Remplacez par la route actuelle
      ),
    );
  }
}
