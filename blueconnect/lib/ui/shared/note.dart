// import 'package:flutter/material.dart';

// PopupMenuButton(
//                 child: Icon(
//                   Icons.more_vert,
//                   color: KPrimaryWhite,
//                 ),
//                 itemBuilder: (context) => [
//                   PopupMenuItem(
//                       child: GestureDetector(
//                     onTap: () {
//                       model.navigateToProfile();
//                     },
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.account_circle,
//                           color: KSecondaryColorDarkGrey,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Profile")
//                       ],
//                     ),
//                   )),
//                   PopupMenuItem(
//                       child: GestureDetector(
//                     onTap: () {
//                       model.navigateToSettings();
//                     },
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.settings,
//                           color: KSecondaryColorDarkGrey,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Setting")
//                       ],
//                     ),
//                   )),
//                   PopupMenuItem(
//                       child: GestureDetector(
//                     onTap: () async {
//                       await model.signOut();
//                     },
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.exit_to_app,
//                           color: KSecondaryColorDarkGrey,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Sign Out")
//                       ],
//                     ),
//                   ))
//                 ],
//               ),