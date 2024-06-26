import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/auth_bloc_ex.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  final String password;
  const OTPScreen({super.key, required this.email, required this.password});

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  String otp = '';
  bool isCountingDown = true;
  bool isOTPVerified = false;
  int countdownSeconds = 180;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSignUpPressed(String code) {
    final email = widget.email;
    final password = widget.password;
    context.read<AuthBloc>().add(
          RegisterWithEmailAndPasswordEvent(
            email: email,
            password: password,
            otp: code,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifiedState) {
          _stopCountdown();
          Fluttertoast.showToast(
            msg: "Sign up success! Login now ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
          Navigator.of(context).pushNamed(AppRoutes.login);
        }
        if (state is VerifiedFailState) {
          Fluttertoast.showToast(
            msg: "${state.error?.response?.data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: const Text(tEmailVerify),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.signup);
              },
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(48),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    tOtpTitle,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 80.0),
                  ),
                  Text(
                    tOtpSubTitle.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    "Enter the verification code sent at zesttravel@support.com",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20.0),
                  OtpTextField(
                    mainAxisAlignment: MainAxisAlignment.center,
                    numberOfFields: 6,
                    filled: true,
                    onSubmit: (code) {
                      _onSignUpPressed(code);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton(
                      onPressed: () {
                        if (!isCountingDown) {
                          context
                              .read<AuthBloc>()
                              .add(VerificationEmailEvent(email: widget.email));
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Resend OTP in',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  " (${countdownSeconds ~/ 60}:${(countdownSeconds % 60).toString().padLeft(2, '0')})",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isOTPVerified) {
                          context.read<AuthBloc>().add(
                                VerificationEmailEvent(
                                  email: widget.email,
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Waiting!"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(color: whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isCountingDown) {
        timer.cancel(); // Dừng đồng hồ đếm ngược nếu cờ đã được đặt thành false
      } else if (countdownSeconds <= 0) {
        timer.cancel(); // Dừng đồng hồ đếm ngược khi hết thời gian
        _stopCountdown();
      } else {
        setState(() {
          countdownSeconds--;
        });
      }
    });
  }

  void _stopCountdown() {
    setState(() {
      isCountingDown = false;
      isOTPVerified = false;
    });
  }
}
