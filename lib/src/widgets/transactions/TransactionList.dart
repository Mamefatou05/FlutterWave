import 'package:flutter/material.dart';
import '../../models/TrasactionModel.dart';
import '../../models/UserModel.dart';
import '../../providers/UserProvider.dart';
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
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          final bool isReceived = transaction.isReceived(user.numeroTelephone);
          return TransactionCard(transaction: transaction, isReceived: isReceived);
        },
      ),
    );
  }
}
