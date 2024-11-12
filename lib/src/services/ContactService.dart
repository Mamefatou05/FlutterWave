import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {
  // Vérifier et demander la permission d'accéder aux contacts
  Future<bool> _requestPermission() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
    }
    return status.isGranted;
  }

  // Récupérer la liste des contacts avec gestion des permissions
  Future<List<Contact>> fetchContacts() async {
    if (await _requestPermission()) {
      final contacts = await ContactsService.getContacts();
      return contacts.toList(); // Convertir Iterable<Contact> en List<Contact>
    } else {
      throw Exception("Permission d'accéder aux contacts refusée");
    }
  }
}
