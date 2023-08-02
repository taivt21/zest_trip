import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/auth/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/auth/domain/entities/auth_user.dart';
import 'package:zest_trip/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<AuthUser>> loginWithEmailAndPassword(
      String email, String password) async {
    return await _authApiService.loginWithEmailAndPassword(email, password);
  }

  @override
  Future<DataState<AuthUser>> registerWithEmailAndPassword(String email,
      String password, String fullName, String dob, String gender) async {
    return await _authApiService.registerWithEmailAndPassword(
        email, password, fullName, dob, gender);
  }

  @override
  Future<DataState<AuthUser>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final String? email = userCredential.user?.email;
      final String? displayName = userCredential.user?.displayName;
      final String? photoUrl = userCredential.user?.photoURL;

      // Now you can send this information to your backend using the AuthApiService
      final String? accessToken = userCredential.user?.getIdToken() as String?;
      print(accessToken);
      // final response =
      //     await _authApiService.signInWithGoogle(accessToken ?? '');

      // Map the response to your domain entity AuthUser if needed
      // final authUser = AuthUser(
      //   id: response.data?.id ?? '',
      //   email: response.data?.email ?? '',
      //   // Map other properties...
      // );
      final authUser = AuthUser(
        // id: id ?? '',
        email: email ?? '',
        fullName: displayName ?? '',
        avatarImageUrl: photoUrl ?? '',
        // Map other properties...
      );

      // Return DataSuccess with the AuthUser
      return DataSuccess(authUser);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
