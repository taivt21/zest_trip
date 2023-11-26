import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour_manage.dart';
import 'package:zest_trip/features/payment/domain/entities/invoice_entity.dart';
import 'package:zest_trip/features/payment/presentation/bloc/booking/booking_bloc.dart';
import 'package:zest_trip/get_it.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BookingBloc>(
          create: (context) => sl()..add(const GetBookings()),
        ),
      ],
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My Bookings"),
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Accepted'),
                Tab(text: 'Pending'),
                Tab(text: 'Refunded'),
                Tab(text: 'Refunding'),
                Tab(text: 'Cancelled by provider'),
              ],
            ),
          ),
          body: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              if (state is GetBookingSuccess) {
                List<InvoiceEntity> invoices = state.bookings!;
                return TabBarView(
                  children: [
                    _buildTabContent(context, invoices, 'accepted'),
                    _buildTabContent(context, invoices, 'pending'),
                    _buildTabContent(context, invoices, 'refunded'),
                    _buildTabContent(context, invoices, 'user_request_refund'),
                    _buildTabContent(context, invoices, 'provider_refunded'),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(
      BuildContext context, List<InvoiceEntity> invoices, String status) {
    String frontendStatus = _mapStatus(status);

    List<InvoiceEntity> filteredInvoices = invoices
        .where((invoice) => invoice.status?.toLowerCase() == frontendStatus)
        .toList();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(color: colorBackground),
      child: filteredInvoices.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "No trips ${frontendStatus.replaceAll('_', ' ')}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.landingScreen);
                  },
                  child: const Text("Search for your trip now"),
                ),
              ],
            )
          : ListView.builder(
              itemCount: filteredInvoices.length,
              itemBuilder: (context, index) {
                return CardTourManage(
                  invoice: filteredInvoices[index],
                );
              },
            ),
    );
  }

  String _mapStatus(String backendStatus) {
    Map<String, String> statusMap = {
      'accepted': 'accepted',
      'pending': 'pending',
      'rejected': 'refunded',
      'refunded': 'refunded',
      'user_request_refund': 'user_request_refund',
      'provider_refunded': 'provider_refunded',
    };

    return statusMap[backendStatus.toLowerCase()] ?? 'pending';
  }
}
