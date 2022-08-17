
// AppBar searchAppBar(context){
//   return AppBar(
//     elevation: 0,
//      
//     toolbarHeight: 80,
//     leading: IconButton(
//       icon: Icon(
//         Icons.arrow_back,
//         color: Colors.grey[600],
//         size: 30,
//       ),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     ),
//     centerTitle: true,
//     shape: ContinuousRectangleBorder(
//       borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
//     ),
//     title: Text(
//       "Results",
//       style: TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.w600,
//         color: Colors.black,
//       ),
//     ),
//     bottom: PreferredSize(
//       preferredSize: Size(60, sizeFromHeight(5)),
//       child: Container(
//         height: sizeFromHeight(5.3),
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 20.0,
//             right: 20,
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 7,
//                     child: Container(
//                       height: sizeFromHeight(14),
//                       decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(
//                             10,
//                           )),
//                       child: TextFormField(
//                         cursorColor: Colors.grey[500],
//                         cursorHeight: sizeFromHeight(17),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(
//                             bottom: 15,
//                             left: 10,
//                           ),
//                           border: InputBorder.none,
//                           suffixIcon: Icon(
//                             Icons.search,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: InkWell(
//                       onTap: () {
//                         showMaterialModalBottomSheet(
//                           enableDrag: true,
//                           builder: (context) => Container(
//                             height: sizeFromHeight(1.1),
//                             width: 42.w,
//                             child: new Container(
//                                 decoration: new BoxDecoration(
//                                     color: ColorManager.WhiteScreen,
//                                     borderRadius: new BorderRadius.only(
//                                         topLeft:
//                                         const Radius.circular(20.0),
//                                         topRight:
//                                         const Radius.circular(20.0))),
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         child: Column(
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.center,
//                                               child: Padding(
//                                                 padding:
//                                                 const EdgeInsets.all(
//                                                     20.0),
//                                                 child: Container(
//                                                   width: sizeFromWidth(3),
//                                                   height: 10,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.black54,
//                                                       borderRadius:
//                                                       BorderRadius
//                                                           .circular(5)),
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets
//                                                   .symmetric(
//                                                   horizontal: 20.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Filter",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize: 18),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         "Clear all",
//                                                         style: TextStyle(
//                                                             color: Colors
//                                                                 .black,
//                                                             fontSize: 16),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       FaIcon(
//                                                         FontAwesomeIcons
//                                                             .eraser,
//                                                         color: Colors.black,
//                                                         size: 20,
//                                                       )
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(
//                                                   20.0),
//                                               child: Container(
//                                                 height: sizeFromHeight(13),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       11),
//                                                   border: Border.all(
//                                                       color: ColorManager
//                                                           .AppBarHomeColorIcon,
//                                                       width: 1.5),
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: InkWell(
//                                                         onTap: () {
//                                                           setState(() {
//                                                             indexBottomSheet =
//                                                             0;
//                                                           });
//                                                         },
//                                                         child: Container(
//                                                           height:
//                                                           sizeFromHeight(
//                                                               13),
//                                                           decoration:
//                                                           BoxDecoration(
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 10),
//                                                             color: indexBottomSheet ==
//                                                                 0
//                                                                 ? ColorManager
//                                                                 .AppBarHomeColorIcon
//                                                                 : ColorManager
//                                                                 .WhiteScreen,
//                                                           ),
//                                                           child: Align(
//                                                             alignment:
//                                                             Alignment
//                                                                 .center,
//                                                             child: Text(
//                                                               "Sell",
//                                                               style:
//                                                               TextStyle(
//                                                                 color: indexBottomSheet ==
//                                                                     0
//                                                                     ? ColorManager
//                                                                     .WhiteScreen
//                                                                     : Colors
//                                                                     .black,
//                                                                 fontSize:
//                                                                 18,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       child: InkWell(
//                                                         onTap: () {
//                                                           setState(() {
//                                                             indexBottomSheet =
//                                                             1;
//                                                           });
//                                                         },
//                                                         child: Container(
//                                                           height:
//                                                           sizeFromHeight(
//                                                               13),
//                                                           decoration:
//                                                           BoxDecoration(
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 10),
//                                                             color: indexBottomSheet ==
//                                                                 1
//                                                                 ? ColorManager
//                                                                 .AppBarHomeColorIcon
//                                                                 : ColorManager
//                                                                 .WhiteScreen,
//                                                           ),
//                                                           child: Align(
//                                                             alignment:
//                                                             Alignment
//                                                                 .center,
//                                                             child: Text(
//                                                               "Rent",
//                                                               style:
//                                                               TextStyle(
//                                                                 color: indexBottomSheet ==
//                                                                     1
//                                                                     ? ColorManager
//                                                                     .WhiteScreen
//                                                                     : Colors
//                                                                     .black,
//                                                                 fontSize:
//                                                                 18,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             StackedCustomizeText(),
//                                             StackedCustomizeCardPrice(),
//                                             StackedCustomrequiredField(),
//                                             StackedFinishesAndPaints(),
//                                             StackedAdvertisor(),
//                                           ],
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {},
//                                         child: Padding(
//                                           padding:
//                                           const EdgeInsets.symmetric(
//                                               horizontal: 20.0,
//                                               vertical: 10),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                               BorderRadius.circular(5),
//                                               color: ColorManager
//                                                   .AppBarHomeColorIcon,
//                                             ),
//                                             height: sizeFromHeight(13),
//                                             width: double.infinity,
//                                             child: Align(
//                                               alignment: Alignment.center,
//                                               child: Text(
//                                                 "Show Result",
//                                                 style: TextStyle(
//                                                     color: ColorManager
//                                                         .WhiteScreen,
//                                                     fontSize: 20),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )),
//                           ),
//                           context: context,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(20),
//                             ),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         height: sizeFromHeight(14),
//                         width: sizeFromWidth(8),
//                         decoration: BoxDecoration(
//                           color: ColorManager.AppBarHomeColorIcon,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SvgPicture.asset(
//                             "assets/images/slider.svg",
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "1205 results found",
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                   Container(
//                     width: sizeFromWidth(4),
//                     height: sizeFromHeight(14.5),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                           color: ColorManager.AppBarIconcolorGrey,
//                           width: 1),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               index = 0;
//                             });
//                           },
//                           child: Container(
//                             width: sizeFromWidth(8),
//                             height: sizeFromHeight(14.5),
//                             child: index == 0
//                                 ? Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: SvgPicture.asset(
//                                 "assets/images/viewstream.svg",
//                               ),
//                             )
//                                 : Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: SvgPicture.asset(
//                                 "assets/images/viewstreamgray.svg",
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: sizeFromHeight(14.5),
//                           width: 1,
//                           color: ColorManager.AppBarIconcolorGrey,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               index = 1;
//                             });
//                           },
//                           child: Container(
//                             width: sizeFromWidth(9),
//                             height: sizeFromHeight(14.5),
//                             child: index == 0
//                                 ? Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: SvgPicture.asset(
//                                 "assets/images/menutogle.svg",
//                               ),
//                             )
//                                 : Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: SvgPicture.asset(
//                                 "assets/images/coloredgridview.svg",
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//   )
// }