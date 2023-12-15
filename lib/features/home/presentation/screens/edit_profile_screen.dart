import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/authentication/domain/usecases/upload_image_usecase.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_event.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_state.dart';
import 'package:zest_trip/features/home/presentation/screens/photo_zoom_screen.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  Map<String, IconData> genderIcons = {
    "Male": Icons.male,
    "Female": Icons.female,
    "Other": Icons.transgender,
  };

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: const Text("Edit profile"),
          ),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UserUploadFail) {
                Fluttertoast.showToast(
                  msg: "Upload failed",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                );
              }
              if (state is UploadImageUseCase) {
                Fluttertoast.showToast(
                  msg: "Change",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                );
              }
            },
            child: RefreshIndicator(
              onRefresh: () async {
                final authBloc = BlocProvider.of<AuthBloc>(context);
                authBloc.add(CheckUserLoginEvent());
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                List<String> url = [];
                                url.add(state.user?.avatarImageUrl ??
                                    "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PhotoZoomScreen(
                                            imageUrls: url, initialIndex: 1)));
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 1.0, // Độ dày của border
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 24,
                                  backgroundImage: CachedNetworkImageProvider(
                                    state.user?.avatarImageUrl ??
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBjUp5SKzh4Za73MnliUAnk7RXINX8_mUC3g&usqp=CAU",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  final picker = ImagePicker();

                                  try {
                                    // Chọn ảnh từ thư viện
                                    final XFile? pickedFile = await picker
                                        .pickImage(source: ImageSource.gallery);

                                    if (pickedFile != null && mounted) {
                                      // Kiểm tra và xử lý file ảnh tại đây
                                      context
                                          .read<AuthBloc>()
                                          .add(UploadImageEvent(pickedFile));
                                    } else {
                                      // Người dùng đã hủy chọn ảnh
                                      // print('User canceled image picking');
                                    }
                                  } catch (e) {
                                    // Xử lý lỗi khi chọn ảnh
                                    // debugPrint('Error picking image: $e');
                                  }
                                },
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),

                        // -- Form Fields
                        Column(
                          children: [
                            _buildTextField(
                              initialValue: (state is AuthSuccess)
                                  ? "${state.user?.email}".split('@').first
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
                            _buildDateField(context),
                            const SizedBox(height: 20),
                            _buildTextFieldGender(
                              label: "Gender",
                              icon:
                                  genderIcons[_selectedGender] ?? Icons.person,
                              options: ["Male", "Female", "Other"],
                              selectedValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Joined ",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                          text: (state is AuthSuccess)
                                              ? DateFormat("dd MMM yyyy")
                                                  .format(
                                                      state.user?.createdAt ??
                                                          DateTime.now())
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
                                    backgroundColor: colorSuccessSecondary,
                                    elevation: 0,
                                    foregroundColor: colorSuccess,
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none,
                                  ),
                                  child: const Text("Active"),
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
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            padding: const EdgeInsets.all(16),
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
        );
      },
    );
  }

  TextFormField _buildDateField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: dateController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        labelText: 'Date of Birth',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
      onTap: () {
        _selectDate(context);
      },
      validator: _validateDateOfBirth,
      keyboardType: TextInputType.datetime,
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  String? _validateDateOfBirth(String? value) {
    if (_selectedDate == null) {
      return 'Please select your date of birth';
    }
    return null;
  }

  void _saveProfile() {
    // print(
    //     "Saving profile: Name=$_name, Phone=$_phone, DateOfBirth=$_selectedDate, Gender=$_selectedGender");
  }
}
