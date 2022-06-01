import 'dart:async';

import 'package:count_down/features/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountDownCubit extends Cubit<CountDownStates> {
  CountDownCubit() : super(CountDownInit());

  static CountDownCubit of(context) => BlocProvider.of(context);

  late int counter;

  Timer? _timer;

  void startCount() {
    counter = 60;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        if (counter == 0) {
          t.cancel();

          emit(CountDownInit());
        } else {
          counter--;
          emit(CountDownCounting());
        }
      },
    );
  }
}
