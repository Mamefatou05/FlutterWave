import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/LoginModel.dart';
import '../providers/AuthProvider.dart';
import '../widgets/ForgotPasswordButton.dart';
import '../widgets/layout/WaveHeader.dart';
import '../widgets/login/LoginForm.dart';
import '../widgets/login/SignUpPrompt.dart';
import '../widgets/login/WelcomeHeader.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  Future<void> _handleLogin(GlobalKey<FormState> formKey, LoginModel loginModel) async {
    if (formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.login(loginModel); // Pass loginModel as JSON
        if (mounted) { // Vérifiez si le widget est encore monté
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        if (mounted) { // Vérifiez si le widget est encore monté
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) { // Vérifiez si le widget est encore monté
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WaveHeader(
                title: "Connexion",
                subtitle: "Entrez vos informations...",
                showBackButton: false,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoginForm(onLogin: _handleLogin),
                    ForgotPasswordButton(),
                    const SizedBox(height: 24),
                    SignUpPrompt(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
