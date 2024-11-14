import '../models/Response.dart';
import '../models/TrasactionModel.dart';
import '../repositories/ApiRepository.dart';

class TransactionService {
  final ApiRepository _apiRepository;

  TransactionService({required ApiRepository apiRepository}) : _apiRepository = apiRepository;

  Future<TransferResponseDto> findById(int id) async {
    final response = await _apiRepository.get('/transactions/$id');
    return TransferResponseDto.fromJson(response.data);
  }

  Future<List<TransactionListDto>> getMyTransactions({TransactionType? type}) async {
    final endpoint = type != null ? '/transactions/my-transactions?type=${type.name}' : '/transactions/my-transactions';

    try {
      final response = await _apiRepository.get(endpoint);
      print('la liste des transactions');
      print(response.data);
      if (response.data is List) {
        return (response.data as List).map((json) => TransactionListDto.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Erreur lors de la récupération des transactions : $e");
      return [];
    }
  }

  Future<TransferResponseDto> transfer(TransferRequestDto transferRequest) async {
    final response = await _apiRepository.post('/transactions/transfer', transferRequest.toJson());
    print("les donné retourné apres transaction");
    print(response.data);
    return TransferResponseDto.fromJson(response.data);
  }

  Future<List<TransferResponseDto>> multipleTransfer(MultipleTransferRequestDto request) async {
    final response = await _apiRepository.post('/transactions/transfer/multiple', request.toJson());
    if (response.data is List) {
      return (response.data as List).map((json) => TransferResponseDto.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<TransferResponseDto>> findBySenderPhoneNumber(String senderPhoneNumber) async {
    final response = await _apiRepository.get('/transactions/sender/$senderPhoneNumber');
    if (response.data is List) {
      return (response.data as List).map((json) => TransferResponseDto.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<TransferResponseDto>> findByRecipientPhoneNumber(String recipientPhoneNumber) async {
    final response = await _apiRepository.get('/transactions/recipient/$recipientPhoneNumber');
    if (response.data is List) {
      return (response.data as List).map((json) => TransferResponseDto.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<TransferResponseDto>> findByStatus(TransactionStatus status) async {
    final response = await _apiRepository.get('/transactions/status/${status.name}');
    if (response.data is List) {
      return (response.data as List).map((json) => TransferResponseDto.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<TransferResponseDto>> findByTransactionType(TransactionType type) async {
    final response = await _apiRepository.get('/transactions/type/${type.name}');
    if (response.data is List) {
      return (response.data as List).map((json) => TransferResponseDto.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<TransferResponseDto>> findByUserPhoneNumber(String phoneNumber) async {
    final response = await _apiRepository.get('/transactions/user/$phoneNumber');
    if (response.data is List) {
      return (response.data as List).map((json) => TransferResponseDto.fromJson(json)).toList();
    }
    return [];
  }

  Future<CancelTransactionResponseDto> cancelTransfer(CancelTransactionRequestDto cancelRequest) async {
    final response = await _apiRepository.post('/transactions/cancel', cancelRequest.toJson());
    return CancelTransactionResponseDto.fromJson(response.data);
  }
}