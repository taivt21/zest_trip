import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/resources/confirm_dialog.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/domain/entities/province_entity.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_location/tour_recommend_location_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_tag/tour_recommend_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/province/province_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tags/tour_tag_bloc.dart';
import 'package:zest_trip/get_it.dart';

class SelectHobbyScreen extends StatefulWidget {
  const SelectHobbyScreen({Key? key}) : super(key: key);

  @override
  State<SelectHobbyScreen> createState() => _SelectHobbyScreenState();
}

class _SelectHobbyScreenState extends State<SelectHobbyScreen> {
  final Set<int> listTag = <int>{};
  final Set<String> listProvince = <String>{};
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool isMaxItemsReached() {
    return listTag.length >= 5 && listProvince.length >= 5;
  }

  Future<void> _showConfirmationDialog() async {
    bool? confirmed = await DialogUtils.showConfirmDialog(
      context,
      title: 'Confirm skip',
      content: 'Do you want show this page again?',
      noText: 'No',
      yesText: 'Yes',
    );

    if (confirmed == true) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      context.read<TourRecommendLocationBloc>().add(
            AnalyticLocation(locations: listProvince),
          );
      context.read<TourRecommendTagBloc>().add(
            AnalyticTag(tags: listTag),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProvinceBloc>(
          create: (context) => sl()..add(const GetProvinces()),
        ),
        BlocProvider<TourTagBloc>(
          create: (context) => sl()..add(const GetTourTags()),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                _showConfirmationDialog();
              },
              child: const Text(
                'Skip',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
          leading: _currentPage > 0
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                )
              : null,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    BlocBuilder<TourTagBloc, TourTagState>(
                      builder: (context, tourTagState) {
                        return _buildTagPage(tourTagState.tourTags);
                      },
                    ),
                    BlocBuilder<ProvinceBloc, ProvinceState>(
                      builder: (context, provinceState) {
                        return _buildProvincePage(provinceState.provinces);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _currentPage > 0
                        ? () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    child: const Text('Back'),
                  ),
                  Text('${_currentPage + 1} of 2'),
                  _currentPage < 1
                      ? TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text('Next'),
                        )
                      : FilledButton(
                          onPressed: () {
                            context.read<TourRecommendLocationBloc>().add(
                                  AnalyticLocation(locations: listProvince),
                                );
                            context.read<TourRecommendTagBloc>().add(
                                  AnalyticTag(tags: listTag),
                                );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRoutes.home, (route) => false);
                          },
                          child: const Text('Start'),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagPage(List<TourTag>? tags) {
    return Column(
      children: [
        Text(
          "Choose a few keywords that best describe your interests",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: tags?.map((TourTag tag) {
                final int tagId = tag.id!;
                String iconName = tag.name ?? 'default_icon';
                String iconAssetPath = 'assets/icons/tags/$iconName.svg';

                return FilterChip(
                  backgroundColor: whiteColor,
                  side: BorderSide(
                    color:
                        listTag.contains(tagId) ? primaryColor : colorBoldGrey!,
                    width: listTag.contains(tagId) ? 2.5 : 1.0,
                  ),
                  selectedColor: whiteColor,
                  showCheckmark: false,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(
                      iconAssetPath,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: colorPlaceHolder,
                    ),
                  ),
                  label: Text(tag.name ?? ""),
                  selected: listTag.contains(tagId),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        if (listTag.length < 5) {
                          listTag.add(tagId);
                        } else {
                          // Hiển thị thông báo hoặc xử lý khi đạt đến giới hạn
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'You can select up to 5 tags.',
                              ),
                            ),
                          );
                        }
                      } else {
                        listTag.remove(tagId);
                      }
                    });
                  },
                );
              }).toList() ??
              [],
        ),
      ],
    );
  }

  Widget _buildProvincePage(List<ProvinceEntity>? provinces) {
    return ListView(
      children: [
        Text(
          "Choose your favorite location",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: provinces?.map((ProvinceEntity province) {
                return FilterChip(
                  backgroundColor: whiteColor,
                  side: BorderSide(
                    color: listProvince.contains(province.name)
                        ? primaryColor
                        : colorBoldGrey!,
                    width: listProvince.contains(province.name) ? 2.5 : 1.0,
                  ),
                  selectedColor: whiteColor,
                  showCheckmark: false,
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: colorPlaceHolder,
                    ),
                  ),
                  label: Text(province.name ?? ""),
                  selected: listProvince.contains(province.name),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        if (listProvince.length < 5) {
                          listProvince.add(province.name!);
                        } else {
                          // Hiển thị thông báo hoặc xử lý khi đạt đến giới hạn
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'You can select up to 5 locations.',
                              ),
                            ),
                          );
                        }
                      } else {
                        listProvince.remove(province.name);
                      }
                    });
                  },
                );
              }).toList() ??
              [],
        ),
      ],
    );
  }
}
