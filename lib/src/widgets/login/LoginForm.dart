import 'package:flutter/material.dart';

import '../../models/LoginModel.dart';
import '../../utils/Validators.dart';
import '../CustomButton.dart';
import '../CustomTextField.dart';


class LoginForm extends StatefulWidget {
  final Function(GlobalKey<FormState>, LoginModel) onLogin;

  const LoginForm({Key? key, required this.onLogin}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _phoneController,
            label: 'Numéro de téléphone',
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: Validators.validatePhone,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _passwordController,
            label: 'Code PIN',
            prefixIcon: Icons.lock_outline,
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: () {
              final loginModel = LoginModel(
                telephone: _phoneController.text,
                password: _passwordController.text,
              );
              widget.onLogin(_formKey, loginModel);
            },
            child: const Text('SE CONNECTER'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
