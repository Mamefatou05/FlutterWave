import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigation vers la page de récupération de mot de passe
        },
        child: Text('Mot de passe oublié ?'),
      ),
    );
  }
}
