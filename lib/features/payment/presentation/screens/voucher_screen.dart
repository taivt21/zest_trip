import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/widgets/empty_widget.dart';
import 'package:zest_trip/features/payment/presentation/bloc/voucher/voucher_bloc.dart';
import 'package:zest_trip/features/payment/presentation/widgets/coupon_widget.dart';
import 'package:zest_trip/get_it.dart';
// Adjust the import based on your project structure

class VoucherScreen extends StatelessWidget {
  final String tourId;
  const VoucherScreen({Key? key, required this.tourId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VoucherBloc>(
      create: (context) => sl()..add(GetVoucher(tourId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Use promo code"),
        ),
        body: BlocBuilder<VoucherBloc, VoucherState>(
          builder: (context, state) {
            if (state is GetVoucherFail || state is VoucherInitial) {
              const Center(
                child: EmptyWidget(
                    imageSvg: homeSvg, title: "No voucher available "),
              );
            }
            if (state is GetVoucherSuccess) {
              return Container(
                color: colorBackground,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorBoldGrey!,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter promo code',
                                contentPadding: EdgeInsets.only(left: 12),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              border: Border(
                                left: BorderSide(
                                  color: colorBoldGrey!,
                                ),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Redeem',
                                style: TextStyle(color: whiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state.vouchers == null || state.vouchers!.isEmpty
                          ? const Center(
                              child: EmptyWidget(
                                  imageSvg: couponSvg,
                                  title: "No voucher available "),
                            )
                          : ListView.builder(
                              itemCount: state.vouchers!.length,
                              itemBuilder: (context, index) {
                                final voucher = state.vouchers![index];
                                return CouponWidget(voucher: voucher);
                              },
                            ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
