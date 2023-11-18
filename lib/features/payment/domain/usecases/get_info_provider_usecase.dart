import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/provider_entity.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class GetInfoProviderUseCase {
  final PaymentRepository _repository;

  GetInfoProviderUseCase(this._repository);

  Future<DataState<ProviderEntity>> call(String providerId) async {
    return await _repository.getInfoProvider(providerId);
  }
}
