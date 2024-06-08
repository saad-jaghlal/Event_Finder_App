import 'package:flutter/material.dart';

import '../../features/auth/presentation/widget/constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  MyAppBar(this.title, {super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title:  Text(
        title!,
        style: const  TextStyle(color: kPrimaryLightColor),
      ),
      backgroundColor: kPrimaryColor,
      foregroundColor: kPrimaryLightColor,
      elevation: 30.0,
      iconTheme: const IconThemeData(color: kPrimaryLightColor), 
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
