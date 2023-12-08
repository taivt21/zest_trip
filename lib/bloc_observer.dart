import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class MyBlocObserver extends BlocObserver {
  var logger = Logger();
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      logger.t("Bloc create: ${bloc.runtimeType}");
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      logger.i("Bloc event: ${bloc.runtimeType}, $event");
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      logger.i("Bloc change: ${bloc.runtimeType}, $change");
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      logger.i("Bloc transition: $transition");
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e("Bloc error: $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      logger.w('Bloc close: ${bloc.runtimeType}');
    }
  }
}
