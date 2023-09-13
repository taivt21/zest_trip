import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  String otp = ''; // Lưu giá trị OTP ở đây
  bool isCountingDown = true;
  bool isOTPVerified = false;
  int countdownSeconds = 10; // Thời gian đếm ngược ban đầu (3 phút)

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(tEmailVerify),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.signup);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(48),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  tOtpTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80.0),
                ),
                Text(
                  tOtpSubTitle.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 40.0),
                Text(
                  "Enter the verification code sent at zesttravel@support.com",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20.0),
                OtpTextField(
                  autoFocus: true,
                  mainAxisAlignment: MainAxisAlignment.center,
                  numberOfFields: 6,
                  filled: true,
                  onSubmit: (code) {
                    otp = code; // Lưu giá trị OTP khi người dùng nhập
                    _stopCountdown(); // Dừng đồng hồ đếm ngược khi mã đã được nhập
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextButton(
                    onPressed: () {
                      if (!isOTPVerified) {
                        // Gọi sự kiện RegisterWithEmailAndPasswordEvent tại đây
                        // Thay thế dòng dưới bằng mã gọi sự kiện RegisterWithEmailAndPasswordEvent
                        // BlocProvider.of<AuthBloc>(context).add(
                        //   RegisterWithEmailAndPasswordEvent(
                        //     email: yourEmail, // Thay bằng email của người dùng
                        //     password: yourPassword, // Thay bằng mật khẩu của người dùng
                        //     otp: '', // Không có OTP khi gửi lại
                        //   ),
                        // );
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Resend OTP',
                        style: TextStyle(
                          color: isOTPVerified ? Colors.black38 : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                " (${countdownSeconds ~/ 60}:${(countdownSeconds % 60).toString().padLeft(2, '0')})",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (otp.length == 6) {
                        isOTPVerified = true; // Đã xác minh mã OTP thành công
                        Navigator.pop(
                            context, otp); // Trả giá trị OTP về trang trước
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a 6-digit OTP"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      tNext,
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isCountingDown) {
        timer.cancel(); // Dừng đồng hồ đếm ngược nếu cờ đã được đặt thành false
      } else if (isOTPVerified) {
        isCountingDown = false; // Dừng đồng hồ đếm ngược khi mã đã được nhập
      } else if (countdownSeconds <= 0) {
        timer.cancel(); // Dừng đồng hồ đếm ngược khi hết thời gian
        // Thực hiện xử lý khi hết thời gian, ví dụ chuyển đến màn hình khác
      } else {
        setState(() {
          countdownSeconds--; // Giảm thời gian đếm ngược mỗi giây
        });
      }
    });
  }

  // Hàm dừng đồng hồ đếm ngược
  void _stopCountdown() {
    setState(() {
      isCountingDown = false;
    });
  }
}
