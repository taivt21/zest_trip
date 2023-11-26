import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _name = "";
  String _phone = "";
  DateTime? _selectedDate;
  String _selectedGender = "Male";
  final _formKey = GlobalKey<FormState>(); // Add this key
  Map<String, IconData> genderIcons = {
    "Male": Icons.male,
    "Female": Icons.female,
    "Other": Icons.transgender,
  };
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Edit profile"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // -- IMAGE with ICON
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: state.user!.avatarImageUrl!,
                              placeholder: (context, url) => Container(
                                height: 60,
                                width: 60,
                                decoration:
                                    BoxDecoration(color: colorLightGrey),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 60,
                                width: 60,
                                decoration:
                                    BoxDecoration(color: colorLightGrey),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: primaryColor,
                            ),
                            child: const Icon(Icons.edit,
                                color: whiteColor, size: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),

                    // -- Form Fields
                    Column(
                      children: [
                        _buildTextField(
                          initialValue: (state is AuthSuccess)
                              ? "${state.user?.fullName}"
                              : "",
                          label: "Full name",
                          icon: Icons.person,
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        _buildTextField(
                          initialValue: (state is AuthSuccess)
                              ? state.user?.phoneNumber ?? ''
                              : "",
                          label: "Phone number",
                          icon: Icons.phone,
                          onChanged: (value) {
                            setState(() {
                              _phone = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        _buildTextField(
                          initialValue: (state is AuthSuccess)
                              ? "${state.user?.dob}"
                              : "$_selectedDate",
                          label: "Date of Birth",
                          icon: Icons.calendar_today,
                          onChanged: (value) {
                            setState(() {
                              _selectedDate = value;
                            });
                          },
                          readOnly: true,
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null &&
                                pickedDate != _selectedDate) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),

                        _buildTextFieldGender(
                          label: "Gender",
                          icon: genderIcons[_selectedGender] ?? Icons.person,
                          options: ["Male", "Female", "Other"],
                          selectedValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        // -- Form Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButtonCustom(
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                // The form is valid, proceed with saving data
                                _saveProfile();
                              }
                            },
                            text: "Edit profile",
                          ),
                        ),
                        const SizedBox(height: 16),

                        // -- Created Date and Delete Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "Joined ",
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                      text: (state is AuthSuccess)
                                          ? DateFormat("dd MMM yyyy")
                                              .format(state.user!.createdAt!)
                                          : DateFormat("dd MMM yyyy")
                                              .format(DateTime.now()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.redAccent.withOpacity(0.1),
                                elevation: 0,
                                foregroundColor: Colors.red,
                                shape: const StadiumBorder(),
                                side: BorderSide.none,
                              ),
                              child: const Text("Delete"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    Function(dynamic)? onChanged,
    bool readOnly = false,
    VoidCallback? onTap,
    String? initialValue,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      validator: (value) {
        if (label == "Full name" && (value == null || value.length < 5)) {
          return "Name must be at least 5 characters long";
        } else if (label == "Phone number" &&
            (value == null || !RegExp(r'^[0-9]{10,11}$').hasMatch(value))) {
          return "Invalid phone number";
        }
        return null; // No validation error
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
    );
  }

  Widget _buildTextFieldGender({
    required String label,
    required IconData icon,
    void Function(String?)? onChanged,
    List<String>? options,
    String? selectedValue,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
      items: options?.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: selectedValue,
      onChanged: onChanged,
    );
  }

  void _saveProfile() {
    print(
        "Saving profile: Name=$_name, Phone=$_phone, DateOfBirth=$_selectedDate, Gender=$_selectedGender");
  }
}
