import 'package:flutter/material.dart';

class RecentTransactionsWidget extends StatelessWidget {
  final List<dynamic> transactions;
  final VoidCallback onSeeAllPressed;

  const RecentTransactionsWidget({
    Key? key,
    required this.transactions,
    required this.onSeeAllPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions récentes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: onSeeAllPressed,
                  child: const Text(
                    'Voir tout',
                    style: TextStyle(
                      color: Color(0xFF8B5CF6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length > 3 ? 3 : transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                  child: const Icon(
                    Icons.payment,
                    color: Color(0xFF8B5CF6),
                  ),
                ),
                title: Text(
                  'Transaction ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(transaction.dateCreation.toString()),
                trailing: Text(
                  '${transaction.montant} F',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B5CF6),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}