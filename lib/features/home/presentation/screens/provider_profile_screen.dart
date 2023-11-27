import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/payment/presentation/bloc/provider/provider_bloc.dart';
import 'package:zest_trip/get_it.dart';

class ProviderProfileScreeen extends StatefulWidget {
  final String providerId;
  const ProviderProfileScreeen({super.key, required this.providerId});

  @override
  State<ProviderProfileScreeen> createState() => _ProviderProfileScreeenState();
}

class _ProviderProfileScreeenState extends State<ProviderProfileScreeen> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ProviderBloc>(
          create: (context) =>
              sl()..add(GetProviderEvent(providerId: widget.providerId)),
          child: BlocBuilder<ProviderBloc, ProviderState>(
            builder: (context, state) {
              if (state is GetInfoProviderSuccess) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  margin:
                                      EdgeInsets.only(bottom: profileHeight),
                                  child: _buildCoverImage(
                                      state.providerEntity!.bannerImageUrl!)),
                              Positioned(
                                  top: coverHeight - profileHeight / 2,
                                  child: _buildProfileImage(
                                    urlProfile:
                                        state.providerEntity!.avatarImageUrl!,
                                    companyName:
                                        state.providerEntity?.companyName ??
                                            "Company Name",
                                    emailContact: state.providerEntity?.email ??
                                        "Email contact",
                                  )),
                            ],
                          ),
                          Column(children: [_buildBasicInformation()]),
                        ]),
                  ),
                );
              }
              if (state is ProviderInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Text("${state.error?.response?.data["message"]}");
              }
            },
          )),
    );
  }

  Widget _buildCoverImage(String urlBanner) => Container(
        color: colorLightGrey,
        child: CachedNetworkImage(
          imageUrl: urlBanner,
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
  Widget _buildProfileImage(
          {required String urlProfile,
          required String companyName,
          required String emailContact}) =>
      Column(
        children: [
          CircleAvatar(
            radius: profileHeight / 2,
            backgroundColor: Colors.grey.shade800,
            backgroundImage: CachedNetworkImageProvider(
              urlProfile,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            companyName,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            emailContact,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
  Widget _buildBasicInformation() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Provider Name',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Location: Da Nang, Vietnam',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Email: example@example.com',
            style: TextStyle(fontSize: 18),
          ),

          // Add more information as needed
        ],
      ),
    );
  }
}
