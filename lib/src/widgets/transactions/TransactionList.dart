import 'package:flutter/material.dart';
import '../../models/TrasactionModel.dart';
import '../../models/UserModel.dart';
import 'TransactionCard.dart'; // Importez le widget TransactionCard

class TransactionList extends StatelessWidget {
  final List<TransactionListDto> transactions;
  final UserModel user;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions.isEmpty
          ? const Center(
        child: Text(
          'Aucune transaction disponible',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];

          // Retournez un TransactionCard pour chaque transaction
          return TransactionCard(transaction: transaction);
        },
      ),
    );
  }
}
