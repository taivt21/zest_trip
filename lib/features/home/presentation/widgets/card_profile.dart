import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';

// ignore: must_be_immutable
class CardProfile extends StatelessWidget {
  VoidCallback? ontap;
  IconData icon;
  String title;
  Color? colorText;

  CardProfile(
      {Key? key,
      required this.ontap,
      required this.icon,
      required this.title,
      this.colorText = colorBlack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(spaceItem),
        child: Material(
          elevation: 3.0,
          shadowColor: colorPlaceHolder,
          borderRadius: BorderRadius.circular(8),
          child: ListTile(
              onTap: ontap,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  icon,
                  color: primaryColor,
                ),
              ),
              title: Text(title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorText, fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20.0)),
        ));
  }
}
