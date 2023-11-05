import 'package:flutter/material.dart';
import '../../../../config/utils/constants/color_constant.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Use promo code"),
        centerTitle: true,
      ),
      body: Column(
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
            child: ListView(
              children: const [
                // Danh sách các voucher
                VoucherListItem(title: 'Voucher 1', code: 'ABC123'),
                SizedBox(
                  height: 8,
                ),
                VoucherListItem(title: 'Voucher 2', code: 'DEF456'),
                VoucherListItem(title: 'Voucher 3', code: 'GHI789'),
                // Thêm các mục voucher khác ở đây
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VoucherListItem extends StatelessWidget {
  final String title;
  final String code;

  const VoucherListItem({
    super.key,
    required this.title,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 3.0,
        shadowColor: colorBackground,
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            code,
            style: const TextStyle(
              color: colorHint,
            ),
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () {},
            child: const Text(
              'Apply',
              style: TextStyle(
                color: whiteColor,
              ),
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}