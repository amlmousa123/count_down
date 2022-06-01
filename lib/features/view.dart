import 'package:count_down/features/cubit.dart';
import 'package:count_down/features/states.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountDownView extends StatefulWidget {
  const CountDownView({Key? key}) : super(key: key);

  @override
  _CountDownViewState createState() => _CountDownViewState();
}

class _CountDownViewState extends State<CountDownView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CountDownCubit()..startCount(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter pin number',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 30.0),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (value) {
                    print(value);
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveColor: Colors.purple,
                    activeColor: Colors.green,
                    selectedColor: Colors.indigoAccent,
                  ),
                ),
                BlocBuilder<CountDownCubit, CountDownStates>(
                  builder: (context, state) {
                    final cubit = CountDownCubit.of(context);
                    if (state is CountDownInit) {
                      return TextButton(
                        onPressed: cubit.startCount,
                        child: Text('Resend Code'),
                      );
                    }
                    return Text(
                      '00:${cubit.counter.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 20),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
