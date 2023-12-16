import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/authentication/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/authentication/data/models/auth_user_model.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';
import 'package:zest_trip/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<AuthUserModel>> loginWithEmailAndPassword(
      String email, String password) async {
    return await _authApiService.loginWithEmailAndPassword(email, password);
  }

  @override
  Future<DataState<bool>> registerWithEmailAndPassword(
      String email, String password, String otp) async {
    return await _authApiService.registerWithEmailAndPassword(
        email, password, otp);
  }

  @override
  Future<DataState<bool>> verificationEmail(String email) async {
    return await _authApiService.verificationEmail(email);
  }

  @override
  Future<DataState<String>> signInWithGoogle(String accessToken) async {
    try {
      return await _authApiService.signInWithGoogle(accessToken);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      await GoogleSignIn().signOut();

      return DataSuccess<void>(null);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<AuthUser>> signInWithPhoneNumber(String phoneNumber) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<AuthUser>> getUser() async {
    return await _authApiService.getUser();
  }

  @override
  Future<DataState<void>> uploadImage(XFile file) {
    return _authApiService.uploadImage(file);
  }

  @override
  Future<DataState<bool>> uploadProfile(
      String fullname, String phone, DateTime dob, String gender) {
    return _authApiService.uploadProfile(fullname, phone, dob, gender);
  }
}
