import 'package:flutter/material.dart';
import 'package:personal_manager/presentations/common/colors.dart' as colors;

// class AppBarRadius extends AppBar {
//   AppBarRadius(
//     BuildContext context, {
//     Key? key,
//     String? title,
//   }) : super(
//           key: key,
//           title: Text("$title".toUpperCase()),
//           backgroundColor: Colors.grey,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)))
//           // // leading: IconButton(
//           //   // onPressed: onPressBack == null
//           //   //     ? () {
//           //   //         Navigator.pop(context);
//           //   //       }
//           //   //     : onPressBack as void Function()?,
//           //   icon: const Icon(
//           //     Icons.arrow_back_ios_new,
//           //   ),
//           // ),
//           // actions: [
//           //   actionRight ?? const SizedBox(),
//           // ],
//         );
// }
class AppbarRadius extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double? height;
  final BorderRadius? borderRadius;

  const AppbarRadius({super.key, 
    required this.child,
    this.borderRadius,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height?? 120);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          borderRadius: borderRadius ?? const BorderRadius.only(
            bottomLeft: Radius.circular(64),
            bottomRight: Radius.circular(64),
          ),
          color: colors.darkLiver),
      height:  preferredSize.height,
      alignment: Alignment.center,
      child: child,
    );
  }
}
