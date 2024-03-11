import 'package:collection_showcase/presentation/screens/linked_list_showcase_screen.dart';
import 'package:collection_showcase/presentation/screens/list_showcase_screen.dart';
import 'package:collection_showcase/presentation/screens/map_showcase_screen.dart';
import 'package:collection_showcase/presentation/screens/queue_showcase_screen.dart';
import 'package:collection_showcase/presentation/screens/set_showcase_screen.dart';
import 'package:collection_showcase/presentation/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const pages = [
      MapEntry('Список', ListShowcaseScreen()),
      MapEntry('Связный список', LinkedListShowcaseScreen()),
      MapEntry('Таблица', MapShowcaseScreen()),
      MapEntry('Множество', SetShowcaseScreen()),
      MapEntry('Очередь', QueueShowcaseScreen()),
    ];

    return ScreenWidget(
      title: 'Коллекции',
      child: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];

          return ListTile(
            title: Text('${index + 1}. ${page.key}'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => page.value,
                ),
              );
            },
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).iconTheme.color,
            ),
          );
        },
      ),
    );
  }
}
