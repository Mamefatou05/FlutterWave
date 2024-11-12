import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/UserProvider.dart';
import '../../routes/HistoryRoute.dart';
import '../../routes/PlanificationRoute.dart';
import '../../routes/TransactionRoute.dart';
import '../../theme/AppColors.dart';
import '../transactions/RecentTransaction.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    // Combiner les transactions envoyées et reçues
    final allTransactions = [
      ...?user?.transactionsEnvoyees,
      ...?user?.transactionsRecues,
    ];

    // Trier par date
    allTransactions.sort((a, b) => b.dateCreation.compareTo(a.dateCreation));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickActions(context),
          RecentTransactionsWidget(
            transactions: allTransactions,
            onSeeAllPressed: () {
              // Navigation vers l'onglet historique
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    // Définition de quickActions
    final quickActions = [
      {'icon': Icons.send, 'label': 'Envoyer', 'route': TransactionRoute.single},
      {'icon': Icons.schedule, 'label': 'Planification', 'route': PlanificationRoute.create},
      {'icon': Icons.history, 'label': 'Historique', 'route': HistoryRoute.history},
      {'icon': Icons.multiple_stop, 'label': 'Multiple', 'route': TransactionRoute.multiple}, // Route pour les paramètres

    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Actions rapides',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: quickActions.map((action) {
              return _buildActionButton(
                icon: action['icon'] as IconData,
                label: action['label'] as String,
                onTap: () {
                  Navigator.pushNamed(context, action['route'] as String);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
