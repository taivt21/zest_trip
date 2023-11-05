import 'package:flutter/material.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';

class ParticipantBottomSheet extends StatefulWidget {
  const ParticipantBottomSheet({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Add information details',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: TextField(
                          controller: countryCodeController,
                          decoration: const InputDecoration(
                            labelText: 'Country code',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(
                        flex: 8,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      labelText: 'Note',
                    ),
                  ),
                ],
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
    // Lấy thông tin từ các ô input
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
