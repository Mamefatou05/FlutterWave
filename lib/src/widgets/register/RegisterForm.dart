import 'package:flutter/material.dart';

import '../../models/CreateClient.dart';
import '../../models/NotificationTypeModel.dart';
import '../../utils/Validators.dart';
import '../CustomButton.dart';
import '../CustomTextField.dart';
import 'NotificationTypeSelector.dart';
import 'PasswordFields.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final Function(Map<String, dynamic>) onSubmit;

  const RegisterForm({
    Key? key,
    required this.formKey,
    required this.isLoading,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  NotificationType _selectedNotificationType = NotificationType.SMS;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _nameController,
            label: 'Nom complet',
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Le nom complet est requis';
              }
              if (value.length < 2 || value.length > 100) {
                return 'Le nom doit contenir entre 2 et 100 caractères';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _phoneController,
            label: 'Numéro de téléphone',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: Validators.validatePhone,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _emailController,
            label: 'Adresse email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'L\'adresse email est requise';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Adresse email invalide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          PasswordFields(
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
            isPasswordVisible: _isPasswordVisible,
            isConfirmPasswordVisible: _isConfirmPasswordVisible,
            onPasswordVisibilityChanged: (value) {
              setState(() => _isPasswordVisible = value);
            },
            onConfirmPasswordVisibilityChanged: (value) {
              setState(() => _isConfirmPasswordVisible = value);
            },
          ),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: widget.isLoading ? null : _handleSubmit,
            child: widget.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('CRÉER UN COMPTE'),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (widget.formKey.currentState!.validate()) {
      widget.onSubmit({
        'nomComplet': _nameController.text,
        'numeroTelephone': _phoneController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'type': _selectedNotificationType,
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
