import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class MyBlocObserver extends BlocObserver {
  var logger = Logger();
  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.i("Bloc event: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i("Bloc error: $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.i("Bloc transition: $transition");
    super.onTransition(bloc, transition);
  }
}
