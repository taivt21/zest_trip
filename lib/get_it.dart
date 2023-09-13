import 'package:get_it/get_it.dart';
import 'package:zest_trip/features/authentication/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:zest_trip/features/authentication/domain/repositories/auth_repository.dart';
import 'package:zest_trip/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/repository/tour_repository_impl.dart';
import 'package:zest_trip/features/home/domain/repository/tour_repository.dart';
import 'package:zest_trip/features/home/domain/usecases/add_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tags.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tours.dart';
import 'package:zest_trip/features/home/domain/usecases/get_vehicles.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/remote_tour_bloc.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/vehicles/tour_vehicle_bloc.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  // Datasources
  sl.registerLazySingleton<TourApiService>(() => TourApiServiceIml());

  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());

//repo
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

//tour
  sl.registerLazySingleton<GetTourUseCase>(() => GetTourUseCase(sl()));

  sl.registerLazySingleton<GetTourTagsUseCase>(() => GetTourTagsUseCase(sl()));

  sl.registerLazySingleton<GetTourVehiclesUseCase>(
      () => GetTourVehiclesUseCase(sl()));

  sl.registerLazySingleton<AddWishlistUseCase>(() => AddWishlistUseCase(sl()));

  //Blocs
  sl.registerFactory<RemoteTourBloc>(() => RemoteTourBloc(sl(), sl()));

  sl.registerFactory<TourTagBloc>(() => TourTagBloc(sl()));

  sl.registerFactory<TourVehicleBloc>(() => TourVehicleBloc(sl()));

  sl.registerFactory<AuthBloc>(
      () => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl()));
}
