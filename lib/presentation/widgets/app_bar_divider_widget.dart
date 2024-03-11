import 'package:flutter/material.dart';

class AppBarDividerWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).iconTheme.color?.withOpacity(.5),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(1);
}
