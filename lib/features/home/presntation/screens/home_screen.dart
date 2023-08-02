// import 'package:ditour_clean/core/constants/textstyle_constant.dart';
// import 'package:ditour_clean/features/home/presntation/bloc/tour/remote/remote_tour_bloc.dart';
// import 'package:ditour_clean/features/home/presntation/bloc/tour/remote/remote_tour_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomePageScreen extends StatelessWidget {
//   const HomePageScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }

//   _buildAppBar() {
//     return AppBar(
//       title: Text('Home Page', style: TextStyles.defaultStyle.bold),
//     );
//   }
// }

// _buildBody() {
//   return BlocBuilder<RemoteTourBloc, RemoteTourState>(
//       builder: (_, state) {
//     if (state is RemoteTourLoading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     if (state is RemoteTourError) {
//       return const Center(
//         child: Icon(Icons.refresh),
//       );
//     }
//     if (state is RemoteTourDone) {
//       return ListView.builder(
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text('$index'),
//             );
//           },
//           itemCount: state.tours!.length);
//     }
//   });
// }
