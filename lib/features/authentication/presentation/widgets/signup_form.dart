import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/size_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_event.dart';
// import 'package:intl/intl.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  SignUpFormWidgetState createState() => SignUpFormWidgetState();
}

class SignUpFormWidgetState extends State<SignUpFormWidget> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>(); // Create a GlobalKey for the Form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController fullnameController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // DateTime? _selectedDate;
  // final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // fullnameController.dispose();
    // phoneController.dispose();
    // dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Assign the GlobalKey to the Form
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(),
              ),
              validator: _validateEmail, // Assign the email validator function
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
            // TextFormField(
            //   controller: fullnameController,
            //   decoration: const InputDecoration(
            //     prefixIcon: Icon(Icons.person_outline_outlined),
            //     labelText: 'Full Name',
            //     hintText: 'Enter your full name',
            //     border: OutlineInputBorder(),
            //   ),
            //   validator:
            //       _validateFullName, // Assign the full name validator function
            // ),
            // const SizedBox(height: tFormHeight - 20),
            // TextFormField(
            //   controller: phoneController,
            //   decoration: const InputDecoration(
            //     prefixIcon: Icon(Icons.phone),
            //     labelText: 'Phone',
            //     hintText: 'Enter your phone number',
            //     border: OutlineInputBorder(),
            //   ),
            //   validator: _validatePhone, // Assign the phone validator function
            //   keyboardType: TextInputType.phone,
            // ),
            // const SizedBox(height: tFormHeight - 20),
            // TextFormField(
            //   readOnly: true,
            //   controller: dateController,
            //   decoration: const InputDecoration(
            //     prefixIcon: Icon(Icons.calendar_today),
            //     labelText: 'Date of Birth',
            //     border: OutlineInputBorder(),
            //   ),
            //   onTap: () {
            //     _selectDate(context);
            //   },
            //   validator: _validateDateOfBirth,
            //   keyboardType: TextInputType.datetime,
            // ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //forget password
                },
                child: const Text(tForgetPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSignUpPressed, // Assign the sign up function
                child: const Text(tSignup),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Validate email format using regular expression
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email!';
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
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );

  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //       dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
  //     });
  //   }
  // }

  // String? _validateDateOfBirth(String? value) {
  //   if (_selectedDate == null) {
  //     return 'Please select your date of birth';
  //   }
  //   return null;
  // }

  // Validate full name
  // String? _validateFullName(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your full name';
  //   }
  //   return null;
  // }

  // // Validate phone number
  // String? _validatePhone(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your phone number';
  //   }
  //   // Add any additional phone number validation if needed
  //   return null;
  // }

  void _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      // The form is valid, perform sign up
      final email = _emailController.text;
      final password = _passwordController.text;
      // final fullname = fullnameController.text;
      // final phone = phoneController.text;

      // Dispatch the SignUpWithEmailAndPasswordEvent to the AuthBloc
      BlocProvider.of<AuthBloc>(context).add(
        RegisterWithEmailAndPasswordEvent(
          email: email,
          password: password,
          // fullName: fullname,
          // phone: phone,
        ),
      );
    }
  }
}
