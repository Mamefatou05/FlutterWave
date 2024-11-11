import '../config.dart';
import '../core/storage/TokenStorageInterface.dart';
import '../models/Response.dart';
import '../models/TrasactionModel.dart';
import '../repositories/ApiRepository.dart';


class TransactionService {
  final ApiRepository _apiRepository;


  TransactionService({
    required ApiRepository apiRepository,
  })  : _apiRepository = apiRepository;

  Future<TransferResponseDto> findById(int id) async {
    final response = await _apiRepository.get('/transactions/$id');
    return TransferResponseDto.fromJson(response);
  }

  Future<List<TransactionListDto>> getMyTransactions({TransactionType? type}) async {
    final endpoint = type != null ? '/transactions/my-transactions?type=${type.name}' : '/transactions/my-transactions';
    final response = await _apiRepository.get(endpoint);
    return (response as List).map((json) => TransactionListDto.fromJson(json)).toList();
  }

  Future<ApiResponse<TransferResponseDto>> transfer(TransferRequestDto transferRequest) async {
    try {
      final response = await _apiRepository.post(
        '/transactions/transfer',
        transferRequest.toJson(),
      );

      return ApiResponse.fromJson(response);
    } catch (e) {
      return ApiResponse.error(
        "Une erreur est survenue lors de la transaction",
        500,
      );
    }
  }

  Future<List<TransferResponseDto>> multipleTransfer(MultipleTransferRequestDto request) async {
    final response = await _apiRepository.post('/transactions/transfer/multiple', request.toJson());
    return (response as List).map((json) => TransferResponseDto.fromJson(json)).toList();
  }

  Future<List<TransferResponseDto>> findBySenderPhoneNumber(String senderPhoneNumber) async {
    final response = await _apiRepository.get('/transactions/sender/$senderPhoneNumber');
    return (response as List).map((json) => TransferResponseDto.fromJson(json)).toList();
  }

  Future<List<TransferResponseDto>> findByRecipientPhoneNumber(String recipientPhoneNumber) async {
    final response = await _apiRepository.get('/transactions/recipient/$recipientPhoneNumber');
    return (response as List).map((json) => TransferResponseDto.fromJson(json)).toList();
  }

  Future<List<TransferResponseDto>> findByStatus(TransactionStatus status) async {
    final response = await _apiRepository.get('/transactions/status/${status.name}');
    return (response as List).map((json) => TransferResponseDto.fromJson(json)).toList();
  }

  Future<List<TransferResponseDto>> findByTransactionType(TransactionType type) async {
    final response = await _apiRepository.get('/transactions/type/${type.name}');
    return (response as List).map((json) => TransferResponseDto.fromJson(json)).toList();
  }

  Future<List<TransferResponseDto>> findByUserPhoneNumber(String phoneNumber) async {
    final response = await _apiRepository.get('/transactions/user/$phoneNumber');
    return (response as List).map((json) => TransferResponseDto.fromJson(json)).toList();
  }

  Future<CancelTransactionResponseDto> cancelTransfer(CancelTransactionRequestDto cancelRequest) async {
    final response = await _apiRepository.post('/transactions/cancel', cancelRequest.toJson());
    return CancelTransactionResponseDto.fromJson(response);
  }
}
