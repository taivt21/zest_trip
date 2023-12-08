// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/screens/home_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/manage_review_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/webview.dart';
import '../../../../config/utils/constants/color_constant.dart';
import '../../../authentication/presentation/blocs/auth/auth_bloc_ex.dart';
import '../widgets/card_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // -- IMAGE
                    Stack(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: state.user?.avatarImageUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: state.user!.avatarImageUrl!,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: primaryColor),
                            child: IconButton(
                              onPressed: () async {
                                // final picker = ImagePicker();

                                // try {
                                //   // Chọn ảnh từ thư viện
                                //   final pickedFile = await picker.pickImage(
                                //       source: ImageSource.gallery);

                                //   if (pickedFile != null) {
                                //     File imageFile = File(pickedFile.path);

                                //     context
                                //         .read<AuthBloc>()
                                //         .add(UploadImageEvent(imageFile));
                                //   } else {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(
                                //         content:
                                //             Text('Please choose an image.'),
                                //       ),
                                //     );
                                //   }
                                // } catch (e) {
                                //   debugPrint('Error picking image: $e');
                                // }
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: whiteColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                        state.user?.fullName ??
                            state.user!.email!.split('@')[0],
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text(state.user?.email ?? "email",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 16),

                    // -- BUTTON
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () => {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const EditProfileScreen()))
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: Text(
                          "Edit profile",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),

                    /// -- MENU
                    CardProfile(
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeScreen(initialPageIndex: 2)),
                        );
                      },
                      icon: Icons.manage_search,
                      title: "Manage Booking",
                    ),

                    CardProfile(
                      ontap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ManageReviewScreen())),
                      icon: Icons.reviews_outlined,
                      title: "Manage Reivew",
                    ),
                    // CardProfile(
                    //   ontap: null,
                    //   icon: Icons.help_center,
                    //   title: "Help center",
                    // ),
                    CardProfile(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyWebView(
                                  title: "Policy's Zest Travel",
                                  urlWeb:
                                      "https://www.travelperk.com/guides/corporate-travel-policy/"),
                            ));
                      },
                      icon: Icons.policy,
                      title: "Policy",
                    ),
                    CardProfile(
                      ontap: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      icon: Icons.logout,
                      title: "Logout",
                      colorText: Colors.red,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(logoNoLetter),
                        backgroundColor: whiteColor,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Please login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> pickAndUploadImage(BuildContext context) async {}
}
