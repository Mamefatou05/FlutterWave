import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/UserModel.dart';
import '../../providers/TransactionProvider.dart';
import '../../providers/UserProvider.dart';
import '../LoadingIndicator.dart';
import '../transactions/NoTransactionsMessage.dart';
import '../transactions/TransactionList.dart'; // Importez le UserProvider


class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user ;
        final transactionProvider = context.watch<TransactionProvider>();

        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (transactionProvider.isLoading) {
          return const LoadingIndicator();
        }

        final allTransactions = transactionProvider.transactions;

        if (allTransactions.isEmpty) {
          return const NoTransactionsMessage();
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    '${allTransactions.length} transactions',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            TransactionList(transactions: allTransactions, user: user),
          ],
        );
      },
    );
  }
}
