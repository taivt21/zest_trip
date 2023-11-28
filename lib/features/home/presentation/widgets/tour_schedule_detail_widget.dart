import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_schedule_entity.dart';

class TourScheduleWidget extends StatefulWidget {
  final List<TourScheduleEntity> tourSchedules;
  final bool showMore;

  const TourScheduleWidget({
    Key? key,
    required this.tourSchedules,
    required this.showMore,
  }) : super(key: key);

  @override
  TourScheduleWidgetState createState() => TourScheduleWidgetState();
}

class TourScheduleWidgetState extends State<TourScheduleWidget> {
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
        widget.showMore ? _buildViewMoreButton(context) : const SizedBox(),
      ],
    );
  }

  Widget _buildTourDay(TourScheduleEntity schedule) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(schedule.description ?? 'No Description',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 16)),
          const SizedBox(height: 8.0),
          if (schedule.tourScheduleDetails != null)
            for (var detail in schedule.tourScheduleDetails ?? []) ...[
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
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        ' ${detail.from} - ${detail.to}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    detail.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
        ],
      ),
    );
  }

  Widget _buildViewMoreButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _showBottomSheet(context);
      },
      child: Text(
        'View More',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
            decoration: TextDecoration.underline),
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
          showDescriptionBlur: false,
        );
      },
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  final List<TourScheduleEntity> tourSchedules;
  final bool showDescriptionBlur;

  const _BottomSheetContent({
    Key? key,
    required this.tourSchedules,
    required this.showDescriptionBlur,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: DefaultTabController(
        length: tourSchedules.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Schedules'),
            bottom: TabBar(
              isScrollable: tourSchedules.length > 8,
              tabs: tourSchedules
                  .map((schedule) => Tab(
                        child: Text(
                          schedule.title!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ))
                  .toList(),
            ),
          ),
          body: TabBarView(
            children: tourSchedules.map((schedule) {
              return TourScheduleWidget(
                tourSchedules: [schedule],
                showMore: false,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
