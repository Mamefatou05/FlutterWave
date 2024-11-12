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
  List<TransactionListDto> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage; // Pour stocker les erreurs

  TransactionProvider(TransactionService transactionService, UserProvider userProvider)
      : _transactionService = transactionService,
        _userProvider = userProvider;

  bool get loading => _loading;
  String? get error => _error;
  String? get fieldError => _fieldError;
  String? get errorMessage => _errorMessage;


  List<TransactionListDto> get transactions => _transactions;
  bool get isLoading => _isLoading;

  Future<void> fetchTransactions() async {
    _isLoading = true;
    _errorMessage = null; // Réinitialiser le message d'erreur
    notifyListeners();

    try {
      // Appel au service pour récupérer les transactions
      _transactions = await _transactionService.getMyTransactions();

    } catch (error) {
      // En cas d'erreur, stocker le message et notifier les listeners
      _errorMessage = "Erreur lors du chargement des transactions : $error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


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

    final transferRequest = TransferRequestDto(
      senderPhoneNumber: senderPhoneNumber,
      recipientPhoneNumber: receiverPhone,
      amount: amount,
      groupReference: description,
    );


      final response = await _transactionService.transfer(transferRequest);
      _setLoading(false);
      // Vérifie si la réponse est un succès
      if (response != null) {
        return true; // Retourne true si la transaction est réussie
      }
      return false;
  }

  List<TransferResponseDto>? _responses;


  List<TransferResponseDto>? get responses => _responses;

  Future<void> performMultipleTransfer({
    required List<String> receiverPhone,
    required double amount,
    String? description,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      final senderPhoneNumber = _userProvider.user?.numeroTelephone;
      if (senderPhoneNumber == null || senderPhoneNumber.isEmpty) {
        _isLoading = false;
        _error = "Utilisateur non connecté";
        return;
      }
      final transferRequestMultiple = MultipleTransferRequestDto(
        senderPhoneNumber: senderPhoneNumber,
        recipientPhoneNumbers: receiverPhone,
        amount: amount,
        groupReference: description,
      );
      notifyListeners();
      _responses = await _transactionService.multipleTransfer(transferRequestMultiple);

    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}