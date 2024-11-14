import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/Transaction.dart';
import '../../models/TrasactionModel.dart';
import '../../theme/AppColors.dart';

class TransactionCard extends StatelessWidget {
  final TransactionListDto transaction;

  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Déterminez si l'utilisateur est l'émetteur ou le destinataire
    final isReceived = !transaction.estEmetteur;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isReceived ? AppColors.primary : AppColors.secondary,
          child: Icon(
            isReceived ? Icons.arrow_downward : Icons.arrow_upward,
            color: isReceived ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          isReceived
              ? 'De ${transaction.autrePartiePrenante}'
              : 'À ${transaction.autrePartiePrenante}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(transaction.dateCreation),
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
          ],
        ),
        trailing: Text(
          '${transaction.montant.toStringAsFixed(2)} F',
          style: TextStyle(
            color: isReceived ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
