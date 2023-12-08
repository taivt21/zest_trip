import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/domain/entities/provider_entity.dart';

class ProviderProfileDetailScreen extends StatefulWidget {
  final ProviderEntity provider;

  const ProviderProfileDetailScreen({Key? key, required this.provider})
      : super(key: key);

  @override
  State<ProviderProfileDetailScreen> createState() =>
      _ProviderProfileDetailScreenState();
}

class _ProviderProfileDetailScreenState
    extends State<ProviderProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return const Scaffold();
  }
}
