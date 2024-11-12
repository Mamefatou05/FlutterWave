import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/CreateClient.dart';
import '../providers/AuthProvider.dart';
import '../providers/UserProvider.dart';
import '../widgets/layout/WaveHeader.dart';
import '../widgets/register/RegisterForm.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WaveHeader(
                title: "Inscription",
                subtitle: "Entrez vos informations...",
                showBackButton: true, // Afficher le bouton retour
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: RegisterForm(
                  formKey: _formKey,
                  isLoading: _isLoading,
                  onSubmit: _handleRegister,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister(Map<String, dynamic> formData) async {
    setState(() => _isLoading = true);
    try {
      final authProvider = Provider.of<UserProvider>(context, listen: false);

      // Créez un objet CreateClient avec les données de formData
      final createClient = CreateClient(
        nomComplet: formData['nomComplet'],
        numeroTelephone: formData['numeroTelephone'],
        email: formData['email'],
        password: formData['password'],
        confirmPassword: formData['password'],
        type: formData['type'],
      );

      await authProvider.register(createClient); // Appel direct de register
      Navigator.pushReplacementNamed(context, '/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compte créé avec succès ! Vous pouvez maintenant vous connecter.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

}
