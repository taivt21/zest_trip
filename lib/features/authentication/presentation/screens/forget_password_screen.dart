import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email!';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(spaceBody),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  forgotSvg,
                  height: 250,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(tForgetPassword.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 20.0),
                Text("Please enter your email address to reset your password!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 32),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          labelText: tEmail,
                          hintText: tEmail,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                        ),
                        validator:
                            _validateEmail, // Assign the email validator function
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              //naviagate to otpscreen
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              tNext,
                              style: TextStyle(color: whiteColor),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
