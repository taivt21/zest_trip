import 'package:flutter/material.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';

class ParticipantBottomSheet extends StatefulWidget {
  final String? fullname;
  final String? phone;
  final String? email;
  const ParticipantBottomSheet({
    Key? key,
    this.fullname,
    this.phone,
    this.email,
  }) : super(key: key);

  @override
  _ParticipantBottomSheetState createState() => _ParticipantBottomSheetState();
}

class _ParticipantBottomSheetState extends State<ParticipantBottomSheet> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController countryCodeController =
      TextEditingController(text: '+84');
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.fullname ?? "";
    phoneNumberController.text = widget.phone ?? "";
    emailController.text = widget.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add information details"),
        automaticallyImplyLeading: false,
        flexibleSpace: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _handleSaveButtonPress(context);
            },
            child: const Text(
              "Send",
              style:
                  TextStyle(decoration: TextDecoration.underline, fontSize: 15),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          } else if (value.length <= 5) {
                            return 'Full name must be longer than 5 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              readOnly: true,
                              controller: countryCodeController,
                              decoration: const InputDecoration(
                                labelText: 'Country code',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            flex: 8,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (value.length < 9 ||
                                    value.length > 11) {
                                  return 'Phone number must be between 9 and 11 digits';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: noteController,
                        decoration: const InputDecoration(
                          labelText: 'Note',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButtonCustom(
                onPressed: () {
                  _handleSaveButtonPress(context);
                },
                text: "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSaveButtonPress(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      String fullName = fullNameController.text;
      String countryCode = countryCodeController.text;
      String phoneNumber = phoneNumberController.text;
      String email = emailController.text;
      String note = noteController.text;

      Map<String, String> participantInfo = {
        'fullName': fullName,
        'countryCode': countryCode,
        'phoneNumber': phoneNumber,
        'email': email,
        'note': note,
      };

      Navigator.pop(context, participantInfo);
    }
  }
}
