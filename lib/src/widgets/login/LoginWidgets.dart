// lib/widgets/login_form.dart
import 'package:flutter/material.dart';
import '../../models/LoginModel.dart';

class LoginWidgets extends StatefulWidget {
  final Function(LoginModel) onSubmit;

  LoginWidgets({required this.onSubmit});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginWidgets> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Numéro de téléphone'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre numéro de téléphone';
              }
              return null;
            },
            onSaved: (value) => phoneNumber = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Mot de passe'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre mot de passe';
              }
              return null;
            },
            onSaved: (value) => password = value!,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Appel de la fonction `onSubmit` passée par le parent
                widget.onSubmit(LoginModel(telephone: phoneNumber, password: password));
              }
            },
            child: Text('Se connecter'),
          ),
        ],
      ),
    );
  }
}
