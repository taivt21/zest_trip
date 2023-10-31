import 'package:get_it/get_it.dart';
import 'package:zest_trip/features/authentication/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:zest_trip/features/authentication/domain/repositories/auth_repository.dart';
import 'package:zest_trip/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/authentication/domain/usecases/upload_image_usecase.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/repository/tour_repository_impl.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/add_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/get_tags.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/get_tours.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/get_vehicles.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/post_review.dart';
import 'package:zest_trip/features/home/presentation/bloc/tour/remote/remote_tour_bloc.dart';
import 'package:zest_trip/features/home/presentation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/bloc/tour_resource/remote/vehicles/tour_vehicle_bloc.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  // Datasources
  sl.registerLazySingleton<TourApiService>(() => TourApiServiceImpl());

  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());

// repository
  sl.registerLazySingleton<TourRepository>(() => TourRepositoryImpl(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  //UseCases
  //auth
  sl.registerLazySingleton<LoginWithEmailAndPasswordUseCase>(
      () => LoginWithEmailAndPasswordUseCase(sl()));

  sl.registerLazySingleton<RegisterWithEmailAndPasswordUseCase>(
      () => RegisterWithEmailAndPasswordUseCase(sl()));

  sl.registerLazySingleton<SignInWithGoogleUseCase>(
      () => SignInWithGoogleUseCase(sl()));

  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()));

  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
      () => SignInWithPhoneNumberUseCase(sl()));
  sl.registerLazySingleton<VerificationEmailUseCase>(
      () => VerificationEmailUseCase(sl()));
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(sl()));
  sl.registerLazySingleton<UploadImageUseCase>(() => UploadImageUseCase(sl()));

//tour usecase
  sl.registerLazySingleton(() => GetTourUseCase(sl()));

  sl.registerLazySingleton(() => GetTourTagsUseCase(sl()));

  sl.registerLazySingleton(() => GetTourVehiclesUseCase(sl()));

  sl.registerLazySingleton(() => AddWishlistUseCase(sl()));

  sl.registerLazySingleton(() => PostReviewUseCase(sl()));

  //Blocs
  sl.registerFactory(
      () => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory(() => RemoteTourBloc(sl(), sl(), sl()));

  sl.registerFactory(() => TourTagBloc(sl()));

  sl.registerFactory(() => TourVehicleBloc(sl()));
}
