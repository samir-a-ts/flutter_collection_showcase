import 'package:collection_showcase/presentation/widgets/app_bar_divider_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const AppBarWidget({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    Widget? leading;

    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      leading = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: navigator.pop,
      );
    }

    return AppBar(
      title: Text(title ?? 'Множество'),
      bottom: const AppBarDividerWidget(),
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
