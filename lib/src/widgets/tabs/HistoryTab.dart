import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/UserProvider.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Combiner et trier toutes les transactions
    final allTransactions = [
      ...user.transactionsEnvoyees,
      ...user.transactionsRecues,
    ];

    // Trier par date de création (plus récente en premier)
    allTransactions.sort((a, b) =>
        b.dateCreation.compareTo(a.dateCreation)
    );

    if (allTransactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune transaction',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // En-tête avec filtres (à implémenter si nécessaire)
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
              // Ajouter des filtres ici si nécessaire
            ],
          ),
        ),
        // Liste des transactions
        Expanded(
          child: ListView.builder(
            itemCount: allTransactions.length,
            itemBuilder: (context, index) {
              final transaction = allTransactions[index];
              final bool isReceived = user.transactionsRecues.contains(transaction);

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isReceived ? Colors.green[100] : Colors.red[100],
                    child: Icon(
                      isReceived ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isReceived ? Colors.green : Colors.red,
                    ),
                  ),
                  title: Text(
                    isReceived
                        ? 'Reçu de ${transaction.expediteur?.nomComplet ?? "Inconnu"}'
                        : 'Envoyé à ${transaction.destinataire?.nomComplet ?? "Inconnu"}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(transaction.dateCreation),
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '${transaction.montant} F',
                    style: TextStyle(
                      color: isReceived ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    // Afficher les détails de la transaction
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }


}