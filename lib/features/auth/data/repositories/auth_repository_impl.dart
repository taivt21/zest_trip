import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/auth/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/auth/data/models/auth_user_model.dart';
import 'package:zest_trip/features/auth/domain/entities/auth_user.dart';
import 'package:zest_trip/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<AuthUserModel>> loginWithEmailAndPassword(
      String email, String password) async {
    return await _authApiService.loginWithEmailAndPassword(email, password);
  }

  @override
  Future<DataState<AuthUserModel>> registerWithEmailAndPassword(String email,
      String password, String fullName, String phone, String gender) async {
    return await _authApiService.registerWithEmailAndPassword(
        email, password, fullName, phone, gender);
  }

  @override
  Future<DataState<AuthUserModel>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken ?? "",
        idToken: googleAuth?.idToken ?? "",
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final String email = userCredential.user?.email ?? '';
      final String displayName = userCredential.user?.displayName ?? '';
      final String photoUrl = userCredential.user?.photoURL ?? '';

      // Now you can send this information to your backend using the AuthApiService
      // final String accessToken = userCredential.user!.getIdToken() as String;

      // final response =
      //     await _authApiService.signInWithGoogle(accessToken ?? '');

      // Map the response to your domain entity AuthUser if needed
      // final authUser = AuthUser(
      //   id: response.data?.id ?? '',
      //   email: response.data?.email ?? '',
      //   // Map other properties...
      // );
      final authUser = AuthUserModel(
        // id: id ?? '',
        email: email,
        fullName: displayName,
        avatarImageUrl: photoUrl,
        // Map other properties...
      );
      // Return DataSuccess with the AuthUser
      return DataSuccess(authUser);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      // Thực hiện các bước để đăng xuất người dùng tại đây
      // Ví dụ: Đăng xuất khỏi Firebase Authentication
      await FirebaseAuth.instance.signOut();

      // Đăng xuất khỏi GoogleSignIn (nếu bạn sử dụng GoogleSignIn)
      await GoogleSignIn().signOut();

      // Nếu có các bước xử lý khác khi đăng xuất, bạn cần thực hiện ở đây

      // Nếu thành công, trả về DataSuccess<void> (không có dữ liệu)
      return DataSuccess<void>(null);
    } on DioException catch (e) {
      // Nếu xảy ra lỗi trong quá trình đăng xuất, trả về DataFailed với thông báo lỗi
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<AuthUser>> signInWithPhoneNumber(String phoneNumber) {
    // TODO: implement loginWithPhoneNumber
    throw UnimplementedError();
  }
}
