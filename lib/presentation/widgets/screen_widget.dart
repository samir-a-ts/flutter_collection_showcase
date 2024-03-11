import 'package:collection_showcase/presentation/widgets/app_bar_widget.dart';
import 'package:collection_showcase/presentation/widgets/background_widget.dart';
import 'package:flutter/material.dart';

class ScreenWidget extends StatelessWidget {
  final String? title;

  final Widget? child;

  const ScreenWidget({
    super.key,
    this.title,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: title ?? 'Множество'),
      body: BackgroundWidget(
        child: child,
      ),
    );
  }
}
