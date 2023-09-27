// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:zest_trip/config/theme/custom_elevated_button.dart';
// import 'package:zest_trip/config/utils/constants/color_constant.dart';
// import 'package:zest_trip/config/utils/constants/image_constant.dart';
// import 'package:zest_trip/config/utils/constants/text_constant.dart';
// import 'package:zest_trip/features/home/presntation/widgets/bottomsheet_booking.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final destination = ModalRoute.of(context)?.settings.arguments as Place;
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(Icons.arrow_back),
//         title: const Text("Place details"),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         actions: [
//           IconButton(
//               onPressed: null,
//               icon: CircleAvatar(
//                 backgroundColor: whiteColor,
//                 child: SvgPicture.asset(
//                   heartSvg,
//                   height: 20,
//                 ),
//               ))
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.4,
//             width: MediaQuery.of(context).size.width,
//             alignment: Alignment.topCenter,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//               child: Image.asset(
//                 tBannerQC,
//                 height: MediaQuery.of(context).size.height * 0.4,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "name",
//                               style: Theme.of(context).textTheme.headlineMedium,
//                             ),
//                             const SizedBox(height: 8),
//                             const Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Icon(
//                                   Icons.place,
//                                   color: Colors.red,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text("location"),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 Wrap(spacing: -24, children: [
//                                   Container(
//                                     height: 48,
//                                     width: 48,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Colors.white,
//                                         width: 2,
//                                       ),
//                                       shape: BoxShape.circle,
//                                       image: const DecorationImage(
//                                         image: AssetImage(tBannerQC),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   )
//                                 ]
//                                     // destination.testimonials
//                                     //     .map((e) =>

//                                     // .toList(),
//                                     ),
//                                 const SizedBox(width: 8),
//                                 TextButton(
//                                   onPressed: () {},
//                                   child: const Text(
//                                     "see what they say.",
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.amber[100],
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: const Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.star_rounded,
//                                   color: Colors.amber,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text("4.5"),
//                                 SizedBox(width: 8),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "price",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headlineSmall
//                                       ?.copyWith(
//                                         color: primaryColor,
//                                       ),
//                                 ),
//                                 const TextSpan(text: "\n"),
//                                 TextSpan(
//                                   text: "/Person",
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     "headline",
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     "description",
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: 56,
//             margin: EdgeInsets.only(
//               bottom: MediaQuery.of(context).padding.bottom,
//               left: 8,
//               right: 16,
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 32.0,
//                   backgroundColor: Colors.grey[100],
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.bookmark,
//                       size: 32,
//                       color: primaryColor,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButtonCustom(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         isScrollControlled: true,
//                         shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(16))),
//                         context: context,
//                         builder: (context) {
//                           return Container(
//                               height: MediaQuery.of(context).size.height * 0.7,
//                               padding: const EdgeInsets.all(16),
//                               child: const BookingBottomSheet());
//                         },
//                       );
//                     },
//                     text: tCheckAvailable,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
