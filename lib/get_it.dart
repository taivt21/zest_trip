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
import 'package:zest_trip/features/home/domain/usecases/add_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/get_reviews.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tags.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tours.dart';
import 'package:zest_trip/features/home/domain/usecases/get_vehicles.dart';
import 'package:zest_trip/features/home/domain/usecases/post_review.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour/remote/remote_tour_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/remote/reviews/tour_reviews_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/remote/vehicles/tour_vehicle_bloc.dart';
import 'package:zest_trip/features/payment/data/datasources/payment_api_service.dart';
import 'package:zest_trip/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';
import 'package:zest_trip/features/payment/domain/usecases/check_available_usecase.dart';
import 'package:zest_trip/features/payment/domain/usecases/create_booking.dart';
import 'package:zest_trip/features/payment/presentation/bloc/payment/payment_bloc.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  // Datasources
  sl.registerLazySingleton<TourApiService>(() => TourApiServiceImpl());

  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());

  sl.registerLazySingleton<PaymentApiService>(() => PaymentApiServiceImpl());

// repository
  sl.registerLazySingleton<TourRepository>(() => TourRepositoryImpl(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(sl()));

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

  sl.registerLazySingleton(() => GetReviewsUseCase(sl()));

  sl.registerLazySingleton<CheckAvailableUseCase>(
      () => CheckAvailableUseCase(sl()));

  sl.registerLazySingleton<CreateBookingUseCase>(
      () => CreateBookingUseCase(sl()));

  //Blocs
  sl.registerFactory(
      () => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory(() => RemoteTourBloc(sl(), sl()));

  sl.registerFactory(() => TourTagBloc(sl()));

  sl.registerFactory(() => TourVehicleBloc(sl()));

  sl.registerFactory(() => TourReviewsBloc(sl(), sl()));

  sl.registerFactory(() => PaymentBloc(sl(), sl()));
}
