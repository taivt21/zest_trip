import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/auth_bloc_ex.dart';
import 'package:zest_trip/features/authentication/presentation/screens/otp_screen.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  SignUpFormWidgetState createState() => SignUpFormWidgetState();
}

class SignUpFormWidgetState extends State<SignUpFormWidget> {
  var logger = Logger();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _navigateToSignUpForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(VerificationEmailEvent(email: _emailController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifyInProgressState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                  email: _emailController.text,
                  password: _passwordController.text),
            ),
          );
        } else {
          Fluttertoast.showToast(
              msg: state.error?.response?.data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint),
                  labelText: tPassword,
                  hintText: tPassword,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _toggleObscureText,
                    icon: const Icon(Icons.remove_red_eye_sharp),
                  ),
                ),
                obscureText: _obscureText,
                validator: _validatePassword,
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: ElevatedButtonCustom(
                  text: tSignup,
                  onPressed: () {
                    _navigateToSignUpForm(context);
                  },
                  backgroundColor: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
