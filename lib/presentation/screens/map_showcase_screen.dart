import 'package:collection_showcase/presentation/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

class DeliveryData {
  final String id;

  final String deliveryTime;

  DeliveryData(this.id, this.deliveryTime);
}

class MapShowcaseScreen extends StatelessWidget {
  const MapShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveries = [
      DeliveryData('1234§2340', '19:00'),
      DeliveryData('1234§2340', '19:00'),
      DeliveryData('1234§2340', '19:00'),
      DeliveryData('2§35243', '12:00'),
      DeliveryData('2§35243', '12:00'),
      DeliveryData('2§35243', '12:00'),
      DeliveryData('2§35243', '12:00'),
      DeliveryData('2§34§2341', '10:00'),
      DeliveryData('2§45§2352', '11:00'),
      DeliveryData('2§35243', '12:00'),
      DeliveryData('2135454', '13:00'),
      DeliveryData('1233147', '16:00'),
      DeliveryData('1234§2340', '19:00'),
      DeliveryData('1234§2340', '19:00'),
      DeliveryData('1234§2340', '19:00'),
      DeliveryData('1233147', '16:00'),
      DeliveryData('1233147', '16:00'),
      DeliveryData('2134256', '15:00'),
      DeliveryData('2134256', '15:00'),
      DeliveryData('2134256', '15:00'),
      DeliveryData('245155', '14:00'),
      DeliveryData('2134256', '15:00'),
      DeliveryData('1233147', '16:00'),
      DeliveryData('81234123', '17:00'),
      DeliveryData('9324', '18:00'),
      DeliveryData('2§45§2352', '11:00'),
      DeliveryData('2§45§2352', '11:00'),
      DeliveryData('2§45§2352', '11:00'),
      DeliveryData('6249', '15:00'),
      DeliveryData('63423', '15:00'),
      DeliveryData('120', '15:00'),
      DeliveryData('6451', '15:00'),
      DeliveryData('6123', '15:00'),
      DeliveryData('1234§2340', '19:00'),
      DeliveryData('2134256', '15:00'),
      DeliveryData('2134256', '15:00'),
      DeliveryData('2134256', '15:00'),
      DeliveryData('1234§2340', '19:00'),
      DeliveryData('1234§2340', '19:00'),
    ];

    /// 1. Сгруппировать по времени доставки

    final map = <String, List<DeliveryData>>{};

    for (final delivery in deliveries) {
      if (map.containsKey(delivery.deliveryTime)) {
        map[delivery.deliveryTime]!.add(delivery);
      } else {
        map[delivery.deliveryTime] = [delivery];
      }
    }

    final entries = map.entries.toList();

    return ScreenWidget(
      title: 'Таблица',
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final delivery = entries[index];

          return _PackageTileWidget(
            deliveryTime: delivery.key,
            counter: delivery.value.length,
          );
        },
      ),
    );
  }
}

class _PackageTileWidget extends StatelessWidget {
  final int counter;

  final String deliveryTime;

  const _PackageTileWidget({
    required this.deliveryTime,
    this.counter = 0,
  });

  @override
  Widget build(BuildContext context) {
    final package = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/package.png'),
          const SizedBox(height: 9),
          Text(
            deliveryTime,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );

    if (counter < 1) {
      return package;
    }

    return Stack(
      children: [
        package,
        Align(
          alignment: Alignment.topLeft,
          child: _CounterWidget(counter: counter),
        ),
      ],
    );
  }
}

class _CounterWidget extends StatelessWidget {
  final int counter;

  const _CounterWidget({
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        shape: BoxShape.circle,
      ),
      child: Text(
        'x$counter',
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
