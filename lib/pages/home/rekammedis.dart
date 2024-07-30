// @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // backgroundColor: const Color(0XFFFF899E),
//         body: Column(
//           children: [
//             SizedBox(
//               height: 570,
//               width: double.maxFinite,
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 22),
//                     padding: EdgeInsets.symmetric(horizontal: 4),
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 290,
//                           width: 290,
//                           decoration: BoxDecoration(
//                             color: const Color(0XFFD9D9D9).withOpacity(0.25),
//                             borderRadius: BorderRadius.circular(144),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // CustomImageView(
//                   //   imagePath: ImageConstant.imgGroupl2,
//                   //   height: 290,
//                   //   width: 288,
//                   //   alignment: Alignment.topLeft,
//                   //   margin: EdgeInsets.only(top: 8),
//                   // ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.topCenter,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: 22,
//                   top: 38,
//                   right: 22,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Rekam Medis",
//                       style: TextStyle(fontFamily: 'Poppins', color: Colors.black)
//                     ),
//                     SizedBox(
//                       width: 108,
//                       child: Divider(),
//                     ),
//                     SizedBox(height: 20),
//                     SizedBox(
//                       width: double.maxFinite,
//                       // child: _buildMamaMedicalHistory(
//                       //   context,
//                       //   medicalHistoryTitle: "Riwayat Medis Janin",
//                       //   moreDetailsText: "Selengkapnya",
//                       // ),
//                     ),
//                     SizedBox(height: 6),
//                     _buildHealthMetrics(context),
//                     SizedBox(height: 16),
//                     SizedBox(
//                       width: double.maxFinite
//                       // child: _buildMamaMedicalHistory(
//                       //   context
//                       //   medicalHistoryTitle: "Riwayat Medis Mama",
//                       //   moreDetailsText: "Selengkapnya",
//                       // ),
//                     ),
//                     SizedBox(height: 6)
//                     // _buildDjvMarDetails(context)
//                   ],
//                 ),
//               ),
//             )
//           ],
//         )
//       )
//     );
//   }

//   Widget _buildHealthMetrics(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 14,
//       ),
//       // decoration: AppDecoration.fillWhiteA.copyWith(
//       //   borderRadius: BorderRadiusStyle.roundedBorder8,
//       // ),
//       width: double.maxFinite,
//       child: Row(
//         children: [
//           // CustomImageView(
//           //   imagePath: ImageConstant.img63967523,
//           //   height: 66,
//           //   width: 66,
//           //   radius: BorderRadius.circular(8),
//           // ),
//           SizedBox(width: 22),
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // _buildColumnOneDetails(
//                   //   context,
//                   //   userImage: ImageConstant.imgFramell3,
//                   //   userDistance: "0 cm",
//                   // ),
//                   SizedBox(
//                     width: 52,
//                     child: Column(
//                       children: [
//                         // CustomImageView(
//                         //   imagePath: ImageConstant.imgTablerHeartbeat,
//                         //   height: 32,
//                         //   width: double.maxFinite,
//                         //   margin: EdgeInsets.symmetric(horizontal: 10),
//                         // ),
//                         SizedBox(height: 6),
//                         Text(
//                           "0 Bpm",
//                           style: TextStyle(fontFamily: 'Poppins', color: Colors.black)
//                         )
//                       ]
//                     )
//                   ),
//                   SizedBox(
//                     width: 44,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // CustomImageView(
//                         //   imagePath: ImageConstant.imgFrame12,
//                         //   height: 32,
//                         //   width: double.maxFinite,
//                         //   margin: EdgeInsets.only(
//                         //     left: 4,
//                         //     right: 6,
//                         //   )
//                         // ),
//                         SizedBox(height: 4),
//                         Text(
//                           "0 cm",
//                           style: TextStyle(fontFamily: 'Poppins', color: Colors.black)
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }