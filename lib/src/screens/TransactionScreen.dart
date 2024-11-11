import 'package:SenCash/src/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/TransactionProvider.dart'; // pour gérer les permissions
class TransactionScreen extends StatefulWidget {
  final UserModel? receiverData;

  const TransactionScreen({
    Key? key,
    this.receiverData,
  }) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.receiverData != null) {
      _phoneController.text = widget.receiverData!.numeroTelephone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Envoyer de l\'argent'),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Champ numéro de téléphone
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Numéro de téléphone',
                          errorText: provider.fieldError == "phone" ? provider.error : null,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un numéro';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.contact_phone),
                      onPressed: _pickContact,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Champ montant
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Montant',
                    suffixText: 'F',
                    errorText: provider.fieldError == "amount" ? provider.error : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un montant';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Montant invalide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Champ description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (optionnel)',
                  ),
                ),
                const SizedBox(height: 24),

                // Message d'erreur général
                if (provider.error != null && provider.fieldError == null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      provider.error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),

                // Bouton envoyer
                ElevatedButton(
                  onPressed: provider.loading ? null : _handleSubmit,
                  child: provider.loading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text('Envoyer'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final transactionProvider = context.read<TransactionProvider>();

    final success = await transactionProvider.sendMoney(
      receiverPhone: _phoneController.text,
      amount: double.parse(_amountController.text),
      description: _descriptionController.text,
    );

    if (success && mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction réussie')),
      );
    }
  }

// Dans votre TransactionScreen, modifiez la méthode _pickContact :
  Future<void> _pickContact() async {
    try {
      var status = await Permission.contacts.status;
      if (!status.isGranted) {
        status = await Permission.contacts.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Permission d'accéder aux contacts refusée")),
          );
          return;
        }
      }

      final contacts = await ContactsService.getContacts();
      if (!mounted) return;

      final Contact? selectedContact = await showDialog<Contact>(
        context: context,
        builder: (context) => ContactPickerDialog(contacts: contacts.toList()),
      );

      if (selectedContact?.phones?.isNotEmpty ?? false) {
        setState(() {
          final phoneNumber = selectedContact!.phones!.first.value!
              .replaceAll(RegExp(r'[^\d+]'), '');
          _phoneController.text = phoneNumber;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de l'accès aux contacts: ${e.toString()}")),
      );
    }
  }

}


class ContactPickerDialog extends StatefulWidget {
  final List<Contact> contacts;

  const ContactPickerDialog({Key? key, required this.contacts}) : super(key: key);

  @override
  State<ContactPickerDialog> createState() => _ContactPickerDialogState();
}

class _ContactPickerDialogState extends State<ContactPickerDialog> {
  late List<Contact> filteredContacts;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredContacts = widget.contacts.toList();
  }

  void _filterContacts(String query) {
    setState(() {
      filteredContacts = widget.contacts.where((contact) {
        final name = contact.displayName?.toLowerCase() ?? '';
        final phone = contact.phones?.firstOrNull?.value?.toLowerCase() ?? '';
        final searchLower = query.toLowerCase();
        return name.contains(searchLower) || phone.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sélectionner un contact'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Rechercher un contact...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterContacts,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.builder(
                itemCount: filteredContacts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final contact = filteredContacts[index];
                  final hasPhone = contact.phones?.isNotEmpty ?? false;

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(contact.displayName?[0].toUpperCase() ?? '?'),
                    ),
                    title: Text(contact.displayName ?? 'Sans nom'),
                    subtitle: Text(
                        hasPhone ? (contact.phones!.first.value ?? '') : 'Pas de numéro'
                    ),
                    enabled: hasPhone,
                    onTap: hasPhone
                        ? () => Navigator.of(context).pop(contact)
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
      ],
    );
  }
}