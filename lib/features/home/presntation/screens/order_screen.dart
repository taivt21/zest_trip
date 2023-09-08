import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/remote_tour_bloc.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/remote_tour_state.dart';
import 'package:zest_trip/features/home/presntation/widgets/tour_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            // Banner section
            height: 200,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: AssetImage(tBannerImage),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search any place...',
                  prefixIcon:
                      const Icon(Icons.search_sharp, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Category', style: AppTextStyles.headline),
                TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: null,
                    child: const Text(
                      'See all',
                      style: TextStyle(color: primaryColor),
                    ))
              ],
            ),
          ),
          BlocBuilder<RemoteTourBloc, RemoteTourState>(
            builder: (context, tourState) {
              if (tourState is RemoteTourDone) {
                return SizedBox(
                  height: 200,
                  width: 200,
                  child: ListView.builder(
                    itemCount: tourState.tours?.length ?? 0,
                    itemExtent:
                        null, // Set itemExtent to null to remove spacing
                    itemBuilder: (context, index) {
                      final tour = tourState.tours![index];
                      return TourItemWidget(
                          tour:
                              tour); // Create a  widgetto display each tour item
                    },
                  ),
                );
              } else {
                return const Text('error');
              }
            },
          ),
          SizedBox(
            // Most Visited section
            height:
                200, // Điều chỉnh kích thước "Most Visited" theo yêu cầu của bạn
            child: ListView(
              scrollDirection: Axis.horizontal, // Cuộn ngang
              children: <Widget>[
                // Thêm các mục "Most Visited" ở đây, mỗi mục có thể là một Container chứa thông tin
                // Ví dụ:
                Container(
                  width: 150,
                  color: Colors.green,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Most Visited Item 1',
                          style: TextStyle(fontSize: 16)),
                      Text('Description 1', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
                // Thêm các mục "Most Visited" khác tương tự
              ],
            ),
          ),
        ],
      ),
    );
  }
}
