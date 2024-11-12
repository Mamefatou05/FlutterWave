import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart';
import '../routes/HomeRoute.dart';
import '../widgets/layout/WaveHeader.dart';
import '../widgets/tabs/HomeTab.dart';
import '../widgets/layout/CustomFooter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    print("Construction de HomeScreen. Utilisateur actuel : $user");

    return Scaffold(
      body: Column(
        children: [
          WaveHeader(
            title: user?.nomComplet ?? 'Mon compte',
            subtitle: user != null ? '${user.solde} F' : '0 F',
            showBackButton: false,
          ),
          if (userProvider.loading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            const Expanded(
              child: HomeTab(),
            ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        currentRoute: HomeRoute.home,
      ),
    );
  }

}