import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../core/di/ServiceLocator.dart';
import '../../services/ContactService.dart';
import 'ContactPickerDialog.dart';

class ContactPickerField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String emptyMessage;
  final bool multipleSelection; // Mode de sélection
  final ValueChanged<List<String>>? onContactsSelected; // Callback pour les sélections multiples
  final TextEditingController searchController; // Contrôleur de recherche

  const ContactPickerField({
    Key? key,
    required this.controller,
    this.label = "Numéro de téléphone",
    this.emptyMessage = "Aucun numéro sélectionné",
    this.multipleSelection = false, // Par défaut, mode simple
    this.onContactsSelected,
    required this.searchController, // Ajouter ce paramètre ici
  }) : super(key: key);

  @override
  State<ContactPickerField> createState() => _ContactPickerFieldState();
}

class _ContactPickerFieldState extends State<ContactPickerField> {
  Future<void> _pickContact() async {
    try {
      final contactService = sl<ContactService>();
      final contacts = await contactService.fetchContacts();

      if (!mounted) return;

      final List<Contact>? selectedContacts = await showDialog<List<Contact>>(
        context: context,
        builder: (context) => ContactPickerDialog(
          contacts: contacts,
          multipleSelection: widget.multipleSelection, // Mode dynamique
          searchController: widget.searchController, // Passer searchController ici
          label: widget.label, // Passer le label ici
        ),
      );

      if (selectedContacts == null || selectedContacts.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.emptyMessage)),
        );
        return;
      }

      // Extraire les numéros de téléphone sélectionnés
      final List<String> phoneNumbers = selectedContacts
          .where((contact) => contact.phones?.isNotEmpty ?? false)
          .map((contact) => contact.phones!.first.value!.replaceAll(RegExp(r'[^\d+]'), ''))
          .toList();

      if (phoneNumbers.isNotEmpty) {
        setState(() {
          if (!widget.multipleSelection) {
            // Mode simple : mettre à jour le champ avec un seul numéro
            widget.controller.text = phoneNumbers.first;
          }
        });

        // Appeler le callback pour le mode multiple
        widget.onContactsSelected?.call(phoneNumbers);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.emptyMessage)),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de l'accès aux contacts : ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: const Icon(Icons.contact_phone),
          onPressed: _pickContact,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
