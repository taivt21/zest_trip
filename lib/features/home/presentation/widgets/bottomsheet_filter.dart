import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/district_entity.dart';
import 'package:zest_trip/features/home/domain/entities/province_entity.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/district/district_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/province/province_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/vehicles/tour_vehicle_bloc.dart';
import 'package:zest_trip/features/home/presentation/widgets/titles_common.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  FilterBottomSheetState createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  final GlobalKey _tagWrapKey = GlobalKey();
  final GlobalKey _vehicleWrapKey = GlobalKey();
  Set<int> listTag = <int>{};
  Set<int> listVehicle = <int>{};
  String? province = "";
  String? district = "";
  String? provinceCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Filters"),
          automaticallyImplyLeading: false,
          flexibleSpace: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Filter
              const Titles(title: "Category"),

              BlocBuilder<TourTagBloc, TourTagState>(
                builder: (context, tourTagState) {
                  if (tourTagState is RemoteTourTagDone) {
                    return _buildFilterPage(
                      tourTagState.tourTags,
                      listTag,
                      _tagWrapKey,
                      (TourTag tag) => tag.id!,
                      (TourTag tag) => tag.name ?? "",
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 16),

              const Titles(title: "Vehicle"),

              BlocBuilder<TourVehicleBloc, TourVehicleState>(
                builder: (context, tourVehicleState) {
                  return _buildFilterPage(
                    tourVehicleState.tourVehicles,
                    listVehicle,
                    _vehicleWrapKey,
                    (TourVehicle vehicle) => vehicle.id!,
                    (TourVehicle vehicle) => vehicle.name ?? "",
                  );
                },
              ),
              const SizedBox(height: 16),

              const Titles(title: "City"),
              BlocBuilder<ProvinceBloc, ProvinceState>(
                builder: (context, provinceState) {
                  if (provinceState is GetProvinceSuccess) {
                    return _buildCity(
                      provinceState.provinces ?? [],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 16),

              const Titles(title: "District"),
              BlocBuilder<DistrictBloc, DistrictState>(
                builder: (context, districtState) {
                  if (districtState is GetDistrictSuccess) {
                    return _buildDistrict(
                      districtState.districts ?? [],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        listTag = {};
                        listVehicle = {};
                        province = "";
                        district = "";
                        provinceCode = "";
                      });
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {
                      Map<String, dynamic> filterValues = {
                        'selectedTags': listTag.toList(),
                        'selectedVehicles': listVehicle.toList(),
                        'selectedProvince': province ?? "",
                        'selectedDistrict': district ?? "",
                      };

                      // Send back the selected values to the previous screen
                      Navigator.pop(context, filterValues);
                    },
                    child: const Text('Apply filter',
                        style: TextStyle(color: whiteColor)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPage<T>(
    List<T>? items,
    Set<int> selectedItems,
    GlobalKey wrapKey,
    int Function(T item) getId,
    String Function(T item) getLabel,
  ) {
    return Column(
      children: [
        Wrap(
          key: wrapKey,
          spacing: 4,
          runSpacing: 0,
          children: items?.map((T item) {
                final int itemId = getId(item);
                return FilterChip(
                  backgroundColor: whiteColor,
                  side: BorderSide(
                    color: selectedItems.contains(itemId)
                        ? primaryColor
                        : colorBoldGrey!,
                    width: selectedItems.contains(itemId) ? 2 : 1,
                  ),
                  selectedColor: whiteColor,
                  showCheckmark: false,
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: colorPlaceHolder,
                    ),
                  ),
                  label: Text(getLabel(item)),
                  selected: selectedItems.contains(itemId),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedItems.add(itemId);
                        print("Selected Items: $selectedItems");
                      } else {
                        selectedItems.remove(itemId);
                        print("Selected Items: $selectedItems");
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

  Widget _buildCity(List<ProvinceEntity> provinces) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        hint: const Text('Choose a province'),
        value: province!.isEmpty ? null : province,
        items: provinces.map((ProvinceEntity province) {
          return DropdownMenuItem<String>(
            value: province.name,
            child: Text(province.name!),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            province = newValue ?? "";
            provinceCode = findProvinceCode(provinces, province ?? "");
            district = "";
          });
        },
      ),
    );
  }

  String? findProvinceCode(List<ProvinceEntity> provinces, String name) {
    for (var province in provinces) {
      if (province.name == name) {
        return province.code;
      }
    }
    return null;
  }

  Widget _buildDistrict(List<DistrictEntity> districts) {
    final List<DistrictEntity> filteredDistricts = districts
        .where((district) => district.provinceCode == provinceCode)
        .toList();
    if (filteredDistricts.isNotEmpty) {
      if (!filteredDistricts.any((d) => d.fullname == district)) {
        district = filteredDistricts.first.fullname;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        value: district!.isEmpty ? null : district,
        hint: const Text('Choose a district'),
        items: filteredDistricts.map((DistrictEntity district) {
          return DropdownMenuItem<String>(
            value: district.fullname,
            child: Text(district.fullname!),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            district = newValue;
            print("$district");
          });
        },
        isExpanded: district != null && district!.isNotEmpty,
      ),
    );
  }
}
