// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';

// enum ExerciseFilter { adventure, cultural, beach, city, nature }

// class SearchField extends StatefulWidget {
//   const SearchField({Key? key}) : super(key: key);

//   @override
//   State<SearchField> createState() => _SearchFieldState();
// }

// class _SearchFieldState extends State<SearchField> {
//   Set<ExerciseFilter> filters = <ExerciseFilter>{};

//   List<String> tourTypes = ['Adventure', 'Cultural', 'Beach', 'City', 'Nature'];

//   @override
//   Widget build(BuildContext context) {
//     var logger = Logger();
//     logger.i('render searhfield');
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Material(
//         elevation: 3.0,
//         shadowColor: Colors.grey.withOpacity(0.5),
//         borderRadius: BorderRadius.circular(40),
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(40),
//                   color: Colors.white,
//                 ),
//                 child: const TextField(
//                   maxLines: 2,
//                   decoration: InputDecoration(
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Colors.black,
//                     ),
//                     border: InputBorder.none,
//                     hintText: 'Where to? \nAnywhere • Any week • Add guests',
//                     hintMaxLines: 2,
//                     hintStyle: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 _showFilterBottomSheet(
//                     context); // Hiển thị BottomSheet khi nhấn vào biểu tượng "tune"
//               },
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Icon(
//                   Icons.tune,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showFilterBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Filter',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Price Range',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Tour type',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Wrap(
//                   spacing: 5.0,
//                   children:
//                       ExerciseFilter.values.map((ExerciseFilter exercise) {
//                     return FilterChip(
//                       label: Text(exercise.name),
//                       selected: filters.contains(exercise),
//                       onSelected: (bool selected) {
//                         setState(() {
//                           if (selected) {
//                             filters.add(exercise);
//                           } else {
//                             filters.remove(exercise);
//                           }
//                         });
//                       },
//                     );
//                   }).toList(),
//                 ),

//                 // Tạo danh sách các loại tour để chọn
//                 // ...
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Rating',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // Tạo danh sách các đánh giá để chọn
//                 // ...
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Clear all',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         )),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black),
//                       onPressed: () {
//                         // Xử lý sự kiện lọc dữ liệu
//                         // ...
//                         Navigator.pop(
//                             context); // Đóng BottomSheet sau khi áp dụng bộ lọc
//                       },
//                       child: const Text('Apply Filters'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
