import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';

class ForgetPasswordConfirmScreen extends StatefulWidget {
  const ForgetPasswordConfirmScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordConfirmScreen> createState() =>
      _ForgetPasswordConfirmScreenState();
}

class _ForgetPasswordConfirmScreenState
    extends State<ForgetPasswordConfirmScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password!';
    }
    // Add additional password validation logic here if needed
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password!';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match!';
    }
    return null;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.fingerprint),
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                          suffixIcon: IconButton(
                            onPressed:
                                _toggleObscureText, // Toggle obscureText when the icon is pressed
                            icon: const Icon(Icons.remove_red_eye_sharp),
                          ),
                        ),
                        validator: _validatePassword,
                        obscureText: _obscureText,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.fingerprint),
                          labelText: "Confirm Password",
                          hintText: tPassword,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                          suffixIcon: IconButton(
                            onPressed:
                                _toggleObscureText, // Toggle obscureText when the icon is pressed
                            icon: const Icon(Icons.remove_red_eye_sharp),
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: _validateConfirmPassword,
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to otpscreen
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            "Change password",
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
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

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
