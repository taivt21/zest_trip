import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedBank = 'Select a Bank'; // Giá trị mặc định
  String selectedCreditCard = 'Select a Credit Card'; // Giá trị mặc định

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete payment"),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a payment method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Widget DropdownButton cho chọn ngân hàng
            DropdownButton<String>(
              value: selectedBank,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBank = newValue!;
                });
              },
              items: <String>[
                'Select a Bank',
                'Bank A',
                'Bank B',
                'Bank C',
                // Thêm danh sách ngân hàng khác nếu cần
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            // Widget DropdownButton cho chọn loại thẻ tín dụng
            DropdownButton<String>(
              value: selectedCreditCard,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCreditCard = newValue!;
                });
              },
              items: <String>[
                'Select a Credit Card',
                'Visa',
                'MasterCard',
                'American Express',
                // Thêm danh sách thẻ khác nếu cần
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            // Widget PaymentOptionCard cho thẻ Credit Card
            PaymentOptionCard(
              icon: Icons.credit_card,
              title: 'Credit Card',
              subtitle: selectedCreditCard,
              onTap: () {
                // Xử lý khi người dùng chọn thẻ tín dụng
              },
            ),
            const SizedBox(height: 16.0),
            PaymentOptionCard(
              subtitle: selectedCreditCard,
              icon: Icons.payment,
              title: 'Other Payment Method',
              onTap: () {
                // Xử lý khi người dùng chọn một phương thức thanh toán khác
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi người dùng nhấn nút thanh toán
                // Có thể sử dụng giá trị của selectedBank và selectedCreditCard ở đây
              },
              child: const Text('Complete Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const PaymentOptionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
