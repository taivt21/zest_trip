import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_schedule_entity.dart';

class TourScheduleWidget extends StatefulWidget {
  final List<TourScheduleEntity> tourSchedules;

  const TourScheduleWidget({Key? key, required this.tourSchedules})
      : super(key: key);

  @override
  TourScheduleWidgetState createState() => TourScheduleWidgetState();
}

class TourScheduleWidgetState extends State<TourScheduleWidget> {
  bool showAllDays = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTourDay(widget.tourSchedules.first),
        if (widget.tourSchedules.length > 1) _buildViewMoreButton(context),
      ],
    );
  }

  Widget _buildTourDay(TourScheduleEntity schedule) {
    return ListTile(
      title: Text(
        schedule.title ?? 'No Title',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(schedule.description ?? 'No Description'),
          const SizedBox(height: 8.0),
          if (schedule.tourScheduleDetails != null)
            for (var detail in schedule.tourScheduleDetails ?? [])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        ' ${detail.from} - ${detail.to}',
                      ),
                    ],
                  ),
                  Text("${detail.description}")
                ],
              )
        ],
      ),
    );
  }

// Ở trong _buildViewMoreButton, thay vì truyền một phần tử duy nhất, truyền toàn bộ danh sách tourSchedules
  Widget _buildViewMoreButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _showBottomSheet(context);
      },
      child: const Text(
        'View More',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      context: context,
      builder: (BuildContext context) {
        return _BottomSheetContent(
          tourSchedules: widget.tourSchedules,
        );
      },
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  final List<TourScheduleEntity> tourSchedules;

  const _BottomSheetContent({Key? key, required this.tourSchedules})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tourSchedules.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Schedules'),
          bottom: TabBar(
            tabs: tourSchedules
                .map((schedule) => Tab(text: schedule.title))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: tourSchedules
              .map((schedule) => TourScheduleWidget(
                    tourSchedules: [schedule],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
