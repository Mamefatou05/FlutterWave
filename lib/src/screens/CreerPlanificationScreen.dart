import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/PlanificationTransfertProvider.dart';
import '../routes/PlanificationRoute.dart';
import '../widgets/layout/CustomFooter.dart';
import '../widgets/layout/WaveHeader.dart';
import '../widgets/planifications/CreerPlanificationForm.dart';


class CreerPlanificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          WaveHeader(
            title: 'Planifier un transfert',
            subtitle: 'Sous-titre optionnel',
            showBackButton: true,
          ),

          // Contenu principal
          Expanded(
            child: Consumer<PlanificationTransfertProvider>(
              builder: (context, provider, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CreerPlanificationForm(
                    onSubmit: (planification) async {
                      await provider.creerPlanification(planification: planification);
                      if (provider.error == null) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),

          // Footer
          CustomFooter(currentRoute: PlanificationRoute.create),
        ],
      ),
    );
  }
}


