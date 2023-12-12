import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/district_entity.dart';
import 'package:zest_trip/features/home/domain/entities/province_entity.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/district/district_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/province/province_bloc.dart';
import 'package:zest_trip/features/home/presentation/widgets/titles_common.dart';
import 'package:zest_trip/get_it.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<TourTag>? listTags;
  final List<TourVehicle>? listVehicle;
  final String? province;
  final String? district;
  final Set<int>? tagIds;
  final Set<int>? vehicleIds;
  final int? fromPrice;
  final int? toPrice;

  const FilterBottomSheet({
    Key? key,
    this.listTags,
    this.listVehicle,
    this.province,
    this.district,
    this.tagIds,
    this.vehicleIds,
    this.fromPrice,
    this.toPrice,
  }) : super(key: key);

  @override
  FilterBottomSheetState createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  final GlobalKey _tagWrapKey = GlobalKey();
  final GlobalKey _vehicleWrapKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _priceFromController = TextEditingController();
  final TextEditingController _priceToController = TextEditingController();

  Set<int> listTag = <int>{};
  Set<int> listVehicle = <int>{};
  String? province = "";
  String? district;
  String? provinceCode = "";

  @override
  void initState() {
    province = widget.province ?? "";

    district = widget.district ?? "";
    listTag = widget.tagIds ?? <int>{};
    listVehicle = widget.vehicleIds ?? <int>{};
    _priceFromController.text =
        widget.fromPrice == -1 ? "" : widget.fromPrice.toString();
    _priceToController.text =
        widget.toPrice == -1 ? "" : widget.toPrice.toString();

    super.initState();
  }

  @override
  void dispose() {
    _priceFromController.dispose();
    _priceToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DistrictBloc>(
          create: (context) => sl()..add(const GetDistricts()),
        ),
        BlocProvider<ProvinceBloc>(
          create: (context) => sl()..add(const GetProvinces()),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _buildAppbar(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Filter
                  const Titles(title: "Category"),

                  _buildFilterPage(
                    widget.listTags,
                    listTag,
                    _tagWrapKey,
                    (TourTag tag) => tag.id!,
                    (TourTag tag) => tag.name ?? "",
                  ),
                  const SizedBox(height: 16),

                  const Titles(title: "Vehicle"),

                  _buildFilterPage(
                    widget.listVehicle,
                    listVehicle,
                    _vehicleWrapKey,
                    (TourVehicle vehicle) => vehicle.id!,
                    (TourVehicle vehicle) => vehicle.name ?? "",
                  ),
                  const SizedBox(height: 16),
                  const Titles(title: "Price range (vnđ)"),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceFromController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "From",
                            hintText: _priceFromController.text,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                          ),
                          validator: (value) {
                            // Kiểm tra nếu "To" không rỗng, "From" phải được nhập
                            if (_priceToController.text.isNotEmpty &&
                                value!.isEmpty) {
                              return 'Please enter';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Text("    -    "),
                      Expanded(
                        child: TextFormField(
                          controller: _priceToController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "To",
                            hintText: _priceToController.text,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                          ),
                          validator: (value) {
                            // Kiểm tra nếu "From" không rỗng, "To" phải được nhập
                            if (_priceFromController.text.isNotEmpty &&
                                value!.isEmpty) {
                              return 'Please enter "To"';
                            }

                            // Kiểm tra nếu "From" lớn hơn hoặc bằng "To"
                            if (_isNumber(_priceFromController.text) &&
                                _isNumber(_priceToController.text) &&
                                double.parse(_priceFromController.text) >=
                                    double.parse(_priceToController.text)) {
                              return 'Invalid price';
                            }

                            // Trường hợp hợp lệ, trả về null
                            return null;
                          },
                        ),
                      ),
                    ],
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
                            _priceFromController.text = "";
                            _priceToController.text = "";
                          });
                        },
                        child: const Text(
                          'Clear',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> filterValues = {
                              'selectedTags': listTag.toList(),
                              'selectedVehicles': listVehicle.toList(),
                              'selectedProvince': province ?? "",
                              'selectedDistrict': district ?? "",
                              'selectedFrom':
                                  _priceFromController.text.isNotEmpty
                                      ? int.parse(_priceFromController.text)
                                      : -1,
                              'selectedTo': _priceToController.text.isNotEmpty
                                  ? int.parse(_priceToController.text)
                                  : -1,
                            };

                            // Send back the selected values to the previous screen
                            Navigator.pop(context, filterValues);
                          }
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
        ),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
        scrolledUnderElevation: 0,
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
        ));
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
                      } else {
                        selectedItems.remove(itemId);
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
        value: district!.isEmpty ? "" : district,
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
            // print("query tour before : $district");
          });
        },
        isExpanded: district != null && district!.isNotEmpty,
      ),
    );
  }

  bool _isNumber(String value) {
    try {
      double.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
