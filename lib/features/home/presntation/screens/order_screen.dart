import 'package:flutter/material.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            // Banner section
            height: 200,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: AssetImage(tBannerImage),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search any place...',
                  prefixIcon:
                      const Icon(Icons.search_sharp, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Category', style: AppTextStyles.headline),
                TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: null,
                    child: const Text(
                      'See all',
                      style: TextStyle(color: primaryColor),
                    ))
              ],
            ),
          ),
          Container(
            height: 100,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.grey.shade50,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 0.0,
                    blurRadius: 10,
                    offset: const Offset(3.0, 3.0)),
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 0.0,
                    blurRadius: 10 / 2.0,
                    offset: const Offset(3.0, 3.0)),
                const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 2.0,
                    blurRadius: 10,
                    offset: Offset(-3.0, -3.0)),
                const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 2.0,
                    blurRadius: 10 / 2,
                    offset: Offset(-3.0, -3.0)),
              ],
            ),
            child: const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade300,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(10, 10),
                            color: Colors.black38,
                            blurRadius: 20)
                      ]),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Futter',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          shadows: [
                            const Shadow(
                                offset: Offset(3, 3),
                                color: Colors.black38,
                                blurRadius: 10),
                            Shadow(
                                offset: const Offset(-3, -3),
                                color: Colors.white.withOpacity(0.85),
                                blurRadius: 10)
                          ],
                          color: Colors.grey.shade300),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(50, 50, 93, 0.25),
                        offset: Offset(0, 30),
                        blurRadius: 60,
                        spreadRadius: -12,
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        offset: Offset(0, 18),
                        blurRadius: 36,
                        spreadRadius: -18,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "BoxShadow",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
