import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/TrasactionModel.dart';
import '../../theme/AppColors.dart';


class TransactionCard extends StatelessWidget {
  final TransactionListDto transaction;
  final bool isReceived;

  const TransactionCard({
    Key? key,
    required this.transaction,
    required this.isReceived,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ? 'Reçu de ${transaction.senderPhoneNumber}'
              : 'Envoyé à ${transaction.recipientPhoneNumber}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy HH:mm').format(transaction.dateCreation),
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Text(
          '${transaction.amount} F',
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
