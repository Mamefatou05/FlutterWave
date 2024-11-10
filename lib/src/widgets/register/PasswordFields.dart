import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Validators.dart';
import '../CustomTextField.dart';

class PasswordFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final ValueChanged<bool> onPasswordVisibilityChanged;
  final ValueChanged<bool> onConfirmPasswordVisibilityChanged;

  const PasswordFields({
    Key? key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.onPasswordVisibilityChanged,
    required this.onConfirmPasswordVisibilityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: passwordController,
          label: 'Code PIN',
          prefixIcon: Icons.lock_outline,
          obscureText: !isPasswordVisible,
          validator: Validators.validatePin,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () => onPasswordVisibilityChanged(!isPasswordVisible),
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: confirmPasswordController,
          label: 'Confirmer le code PIN',
          prefixIcon: Icons.lock_outline,
          obscureText: !isConfirmPasswordVisible,
          validator: (value) {
            if (value != passwordController.text) {
              return 'Les codes PIN ne correspondent pas';
            }
            return null;
          },
          suffixIcon: IconButton(
            icon: Icon(
              isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () => onConfirmPasswordVisibilityChanged(!isConfirmPasswordVisible),
          ),
        ),
      ],
    );
  }
}