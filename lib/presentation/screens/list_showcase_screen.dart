import 'package:collection_showcase/presentation/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

class ListShowcaseScreen extends StatelessWidget {
  const ListShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final integers = List.generate(100, (index) => index);

    final list = List.of(integers);

    /// 1. Посчитать квадраты чисел в списке

    // final list = integers.map((e) => e * e).toList();

    /// 2. Отфильтровать числа, которые делятся на 3

    // final list = integers.where((element) => element % 3 == 0).toList();

    /// 3. Посчитать сумму всх чисел и вывести в заголовке

    final sum = integers.fold(0, (previousValue, element) => previousValue + element);

    return ScreenWidget(
      title: 'Список $sum',
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${index + 1}. Элемент ${list[index]}'),
          );
        },
      ),
    );
  }
}
