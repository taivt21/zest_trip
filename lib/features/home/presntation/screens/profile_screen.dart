// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import '../../../../config/utils/constants/color_constant.dart';
import '../../../authentication/presentation/blocs/auth_bloc_ex.dart';
import '../widgets/card_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Profile',
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
        centerTitle: true,
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
                            child: state.user.avatarImageUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: state.user.avatarImageUrl!,
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
                                : const Image(
                                    image: AssetImage(noAvatar),
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
                            child: const Icon(
                              Icons.edit,
                              color: whiteColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(state.user.fullName ?? state.user.email!,
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text(state.user.email ?? "email",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 16),

                    // -- BUTTON
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () => {},
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
                      ontap: null,
                      icon: Icons.manage_search,
                      title: "Manage Booking",
                    ),

                    CardProfile(
                      ontap: null,
                      icon: Icons.payment,
                      title: "Payment method",
                    ),
                    CardProfile(
                      ontap: null,
                      icon: Icons.help_center,
                      title: "Help center",
                    ),
                    CardProfile(
                      ontap: null,
                      icon: Icons.policy,
                      title: "Policy",
                    ),
                    CardProfile(
                      ontap: () => context.read<AuthBloc>().add(LogoutEvent()),
                      icon: Icons.logout,
                      title: "Logout",
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(logoNoLetter),
                        backgroundColor: whiteColor,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Please login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the login screen when the button is pressed
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
}
