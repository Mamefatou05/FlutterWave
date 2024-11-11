import 'package:flutter/material.dart';

import '../models/TrasactionModel.dart';
import '../services/TransactionService.dart'; // Importer TransactionService
import 'UserProvider.dart';

class TransactionProvider with ChangeNotifier {
  final TransactionService _transactionService;
  final UserProvider _userProvider;

  bool _loading = false;
  String? _error;
  String? _fieldError;

  TransactionProvider(TransactionService transactionService, UserProvider userProvider)
      : _transactionService = transactionService,
        _userProvider = userProvider;

  bool get loading => _loading;
  String? get error => _error;
  String? get fieldError => _fieldError;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _setError(String? value, [String? field]) {
    _error = value;
    _fieldError = field;
    notifyListeners();
  }

  Future<bool> sendMoney({
    required String receiverPhone,
    required double amount,
    String? description,
  }) async {
    _setLoading(true);
    _setError(null);

    final senderPhoneNumber = _userProvider.user?.numeroTelephone;

    if (senderPhoneNumber == null || senderPhoneNumber.isEmpty) {
      _setLoading(false);
      _setError("Utilisateur non connecté");
      return false;
    }



    if (senderPhoneNumber == null || senderPhoneNumber.isEmpty) {
      _setLoading(false);
      _setError("Utilisateur non connecté");
      return false;
    }
    final transferRequest = TransferRequestDto(
      senderPhoneNumber: senderPhoneNumber,
      recipientPhoneNumber: receiverPhone,
      amount: amount,
      groupReference: description,
    );



    try {
      final response = await _transactionService.transfer(transferRequest);
      _setLoading(false);

      if (!response.success) {
        final errorMessage = response.errorMessage ?? "Une erreur est survenue";

        if (errorMessage.contains("Destinataire")) {
          _setError(errorMessage, "phone");
        } else if (errorMessage.contains("solde")) {
          _setError(errorMessage, "amount");
        } else {
          _setError(errorMessage);
        }
        return false;
      }

      // En cas de succès
      return true;

    } catch (e) {
      print("Erreur de transaction: $e");
      _setLoading(false);
      _setError('Une erreur est survenue lors de la transaction');
      return false;
    }

  }
}