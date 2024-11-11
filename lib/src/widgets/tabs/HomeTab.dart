import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/UserProvider.dart';
import '../../routes/TransactionRoute.dart';
import '../../screens/HomeScreen.dart';
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
          _buildQuickActions(context), // Pass context here
          RecentTransactionsWidget(
            transactions: allTransactions,
            onSeeAllPressed: () {
              // Navigation vers l'onglet historique
              // Vous pouvez aussi naviguer vers une nouvelle page si préféré
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) { // Add BuildContext parameter here
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
            children: [
              _buildActionButton(
                icon: Icons.send,
                label: 'Envoyer',
                onTap: () {
                  Navigator.pushNamed(context, TransactionRoute.home); // Pass context here
                },
              ),
              _buildActionButton(
                icon: Icons.qr_code,
                label: 'QR Code',
                onTap: () {
                  // Navigation vers la page QR
                },
              ),
              _buildActionButton(
                icon: Icons.history,
                label: 'Historique',
                onTap: () {
                  // Navigation vers la page historique
                },
              ),
            ],
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
              color: const Color(0xFF8B5CF6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF8B5CF6),
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
