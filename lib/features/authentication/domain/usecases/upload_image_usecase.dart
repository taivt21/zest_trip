import 'package:image_picker/image_picker.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/authentication/domain/repositories/auth_repository.dart';

class UploadImageUseCase {
  final AuthRepository _userRepository;

  UploadImageUseCase(this._userRepository);

  Future<DataState<void>> call(XFile file) async {
    return await _userRepository.uploadImage(file);
  }
}
