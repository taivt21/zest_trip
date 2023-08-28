import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/core/constants/size_constant.dart';
import 'package:zest_trip/core/constants/text_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_event.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  LoginFormWidgetState createState() => LoginFormWidgetState();
}

class LoginFormWidgetState extends State<LoginFormWidget> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>(); // Create a GlobalKey for the Form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.i('render form login');

    return Form(
        key: _formKey, // Assign the GlobalKey to the Form
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: tEmail,
                    hintText: tEmail,
                    border: OutlineInputBorder()),
                validator:
                    _validateEmail, // Assign the email validator function
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint),
                  labelText: tPassword,
                  hintText: tPassword,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed:
                        _toggleObscureText, // Toggle obscureText when the icon is pressed
                    icon: const Icon(Icons.remove_red_eye_sharp),
                  ),
                ),
                obscureText: _obscureText,
                validator:
                    _validatePassword, // Assign the password validator function
              ),
              const SizedBox(height: tFormHeight - 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      //forget password
                    },
                    child: const Text(tForgetPassword)),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onLoginPressed, // Assign the login function
                  child: const Text(tLogin),
                ),
              ),
            ],
          ),
        ));
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Validate email format using regular expression
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Regular expression to check email format
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  // Validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // Add any additional password validation if needed
    return null;
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      // The form is valid, perform login
      final email = _emailController.text;
      final password = _passwordController.text;

      // Dispatch the LoginWithEmailAndPasswordEvent to the AuthBloc
      BlocProvider.of<AuthBloc>(context).add(
        LoginWithEmailAndPasswordEvent(
          email: email,
          password: password,
        ),
      );
    }
  }
}
