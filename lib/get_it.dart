import 'package:get_it/get_it.dart';
import 'package:zest_trip/features/authentication/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:zest_trip/features/authentication/domain/repositories/auth_repository.dart';
import 'package:zest_trip/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/authentication/domain/usecases/update_profile_usecase.dart';
import 'package:zest_trip/features/authentication/domain/usecases/upload_image_usecase.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/repository/tour_repository_impl.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';
import 'package:zest_trip/features/home/domain/usecases/add_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/analytic_location.dart';
import 'package:zest_trip/features/home/domain/usecases/analytic_tag.dart';
import 'package:zest_trip/features/home/domain/usecases/get_banner.dart';
import 'package:zest_trip/features/home/domain/usecases/get_district.dart';
import 'package:zest_trip/features/home/domain/usecases/get_popular_location.dart';
import 'package:zest_trip/features/home/domain/usecases/get_popular_tag.dart';
import 'package:zest_trip/features/home/domain/usecases/get_province.dart';
import 'package:zest_trip/features/home/domain/usecases/get_reviews_tour.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tags.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_detail.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_provider.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_rcm_location.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_rcm_search.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_rcm_tag.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_sponsore.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tours.dart';
import 'package:zest_trip/features/home/domain/usecases/get_vehicles.dart';
import 'package:zest_trip/features/home/domain/usecases/get_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/remove_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/report_provider.dart';
import 'package:zest_trip/features/home/presentation/blocs/banner/banner_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/location_popular/location_popular_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tag_popular/tag_popular_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_of_provider/tour_of_provider_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_location/tour_recommend_location_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_search/tour_recommend_search_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_tag/tour_recommend_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/district/district_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/province/province_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tour_detail/tour_detail_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_sponsore/tour_sponsore_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_wishlist/tour_wishlist_bloc.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_own_review_usecase.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_pricing_tour.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_voucher_of_tour.dart';
import 'package:zest_trip/features/payment/domain/usecases/post_review.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour/remote/remote_tour_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/reviews/tour_reviews_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/vehicles/tour_vehicle_bloc.dart';
import 'package:zest_trip/features/payment/data/datasources/payment_api_service.dart';
import 'package:zest_trip/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';
import 'package:zest_trip/features/payment/domain/usecases/check_available_usecase.dart';
import 'package:zest_trip/features/payment/domain/usecases/create_booking.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_info_provider_usecase.dart';
import 'package:zest_trip/features/payment/domain/usecases/get_own_booking.dart';
import 'package:zest_trip/features/payment/domain/usecases/request_refund_usecase.dart';
import 'package:zest_trip/features/payment/presentation/bloc/booking/booking_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/checking_tour/checking_tour_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/my_review/my_review_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/payment/payment_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/provider/provider_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/refund/refund_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/report_provider/report_provider_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/voucher/voucher_bloc.dart';

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

  sl.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(sl()));

//tour usecase
  sl.registerLazySingleton(() => GetTourUseCase(sl()));

  sl.registerLazySingleton(() => GetTourTagsUseCase(sl()));

  sl.registerLazySingleton(() => GetTourVehiclesUseCase(sl()));

  sl.registerLazySingleton(() => AddWishlistUseCase(sl()));

  sl.registerLazySingleton(() => RemoveWishlistUseCase(sl()));

  sl.registerLazySingleton(() => GetWishlistUseCase(sl()));

  sl.registerLazySingleton(() => PostReviewUseCase(sl()));

  sl.registerLazySingleton(() => GetReviewsUseCase(sl()));

  sl.registerLazySingleton<CheckAvailableUseCase>(
      () => CheckAvailableUseCase(sl()));

  sl.registerLazySingleton<CreateBookingUseCase>(
      () => CreateBookingUseCase(sl()));

  sl.registerLazySingleton<GetInfoProviderUseCase>(
    () => GetInfoProviderUseCase(sl()),
  );
  sl.registerLazySingleton<GetOwnBookingUseCase>(
    () => GetOwnBookingUseCase(sl()),
  );
  sl.registerLazySingleton<GetOwnReviewUseCase>(
    () => GetOwnReviewUseCase(sl()),
  );
  sl.registerLazySingleton<GetVoucherOfTourUseCase>(
    () => GetVoucherOfTourUseCase(sl()),
  );
  sl.registerLazySingleton<RequestRefundUseCase>(
    () => RequestRefundUseCase(sl()),
  );
  sl.registerLazySingleton<GetProvinceUseCase>(
    () => GetProvinceUseCase(sl()),
  );
  sl.registerLazySingleton<GetDistrictUseCase>(
    () => GetDistrictUseCase(sl()),
  );
  sl.registerLazySingleton<AnaLyticLocationUseCase>(
    () => AnaLyticLocationUseCase(sl()),
  );
  sl.registerLazySingleton<AnaLyticTagUseCase>(
    () => AnaLyticTagUseCase(sl()),
  );
  sl.registerLazySingleton<GetTourRcmTagUseCase>(
    () => GetTourRcmTagUseCase(sl()),
  );
  sl.registerLazySingleton<GetTourRcmLocationUseCase>(
    () => GetTourRcmLocationUseCase(sl()),
  );
  sl.registerLazySingleton<GetTourRcmSearchUseCase>(
    () => GetTourRcmSearchUseCase(sl()),
  );
  sl.registerLazySingleton<GetPopularLocationUseCase>(
    () => GetPopularLocationUseCase(sl()),
  );
  sl.registerLazySingleton<GetTourSponsoreUseCase>(
    () => GetTourSponsoreUseCase(sl()),
  );
  sl.registerLazySingleton<GetPopularTagUseCase>(
    () => GetPopularTagUseCase(sl()),
  );

  sl.registerLazySingleton<GetTourDetailUseCase>(
    () => GetTourDetailUseCase(sl()),
  );
  sl.registerLazySingleton<GetTourProviderUseCase>(
    () => GetTourProviderUseCase(sl()),
  );
  sl.registerLazySingleton<ReportProviderUseCase>(
    () => ReportProviderUseCase(sl()),
  );
  sl.registerLazySingleton<GetBannerUseCase>(
    () => GetBannerUseCase(sl()),
  );
  sl.registerLazySingleton<GetPricingTourUseCase>(
    () => GetPricingTourUseCase(sl()),
  );

  //Blocs
  sl.registerFactory(
      () => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory(() => RemoteTourBloc(sl()));

  sl.registerFactory(() => TourWishlistBloc(sl(), sl(), sl()));

  sl.registerFactory(() => TourSponsoreBloc(sl()));

  sl.registerFactory(() => TourRecommendTagBloc(sl(), sl()));

  sl.registerFactory(() => TourRecommendLocationBloc(sl(), sl()));

  sl.registerFactory(() => TourRecommendSearchBloc(sl()));

  sl.registerFactory(() => LocationPopularBloc(sl()));

  sl.registerFactory(() => TagPopularBloc(sl()));

  sl.registerFactory(() => TourTagBloc(sl()));

  sl.registerFactory(() => TourVehicleBloc(sl()));

  sl.registerFactory(() => TourReviewsBloc(sl()));

  sl.registerFactory(() => PaymentBloc(sl(), sl()));

  sl.registerFactory(() => ProviderBloc(sl()));

  sl.registerFactory(() => BookingBloc(sl()));

  sl.registerFactory(() => MyReviewBloc(sl(), sl()));

  sl.registerFactory(() => RefundBloc(sl()));

  sl.registerFactory(() => VoucherBloc(sl()));

  sl.registerFactory(() => ProvinceBloc(sl()));

  sl.registerFactory(() => DistrictBloc(sl()));

  sl.registerFactory(() => TourDetailBloc(sl()));

  sl.registerFactory(() => TourProviderBloc(sl()));

  sl.registerFactory(() => ReportProviderBloc(sl()));

  sl.registerFactory(() => BannerBloc(sl()));

  sl.registerFactory(() => CheckingTourBloc(sl()));
}
