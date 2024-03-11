import 'dart:collection';

import 'package:collection_showcase/presentation/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

final class EntryItem with LinkedListEntry<EntryItem> {
  EntryItem(this.value);

  final int? value;
}

class LinkedListShowcaseScreen extends StatefulWidget {
  const LinkedListShowcaseScreen({super.key});

  @override
  State<LinkedListShowcaseScreen> createState() => _LinkedListShowcaseScreenState();
}

class _LinkedListShowcaseScreenState extends State<LinkedListShowcaseScreen> {
  late final LinkedList<EntryItem> linkedList = LinkedList<EntryItem>();

  @override
  void initState() {
    for (var i = 0; i < 100000; i++) {
      linkedList.add(EntryItem(i));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ScreenWidget(
      title: 'Связанный список',
      child: ListView(
        children: [
          for (var entry in linkedList)
            LongPressDraggable(
              data: entry,
              feedback: Material(
                child: SizedBox(
                  width: size.width,
                  height: 50,
                  child: ListTile(
                    tileColor: Colors.amber,
                    title: Text('Элемент ${entry.value}'),
                  ),
                ),
              ),
              childWhenDragging: Container(
                height: 50,
                width: double.infinity,
                color: Colors.redAccent,
              ),
              child: DragTarget<EntryItem>(
                builder: (context, candidateData, rejectedData) {
                  return ListTile(
                    title: Text('Элемент ${entry.value}'),
                  );
                },
                onAccept: (data) {
                  setState(() {
                    entry.insertBefore(EntryItem(data.value));
                    data.unlink();
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}

// setState(() {
//   entry.insertBefore(EntryItem(data.value));
//   data.unlink();
// });