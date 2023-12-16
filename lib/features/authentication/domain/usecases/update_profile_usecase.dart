import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/authentication/domain/repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository _userRepository;

  UpdateProfileUseCase(this._userRepository);

  Future<DataState<bool>> call(
      String fullname, String phone, DateTime dob, String gender) async {
    return await _userRepository.uploadProfile(fullname, phone, dob, gender);
  }
}
