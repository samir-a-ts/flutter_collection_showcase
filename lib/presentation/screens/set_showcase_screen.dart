import 'package:collection_showcase/presentation/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

class SetShowcaseScreen extends StatefulWidget {
  const SetShowcaseScreen({super.key});

  @override
  State<SetShowcaseScreen> createState() => _SetShowcaseScreenState();
}

class Place {
  final String name;
  final PlaceType type;

  Place(this.name, this.type);
}

enum PlaceType {
  hotel('Отель', 'assets/images/hotel.png'),
  boing747('Боинг 747', 'assets/images/boeing.png'),
  restaurant('Ресторан', 'assets/images/restaurant.png'),
  museum('Музей', 'assets/images/museum.png'),
  park('Парк', 'assets/images/park.png'),
  bar('Бар', 'assets/images/other.png'),
  suspisiousType('Подозрительный тип', 'assets/images/sus.png'),
  cafe('Кафе', 'assets/images/cafe.png'),
  other('Другое', 'assets/images/other.png');

  final String name;

  final String assetPath;

  const PlaceType(this.name, this.assetPath);
}

final List<Place> _places = [
  Place('Ресторан 1', PlaceType.restaurant),
  Place('Кафе 1', PlaceType.cafe),
  Place('Отель 1', PlaceType.hotel),
  Place('Музей 1', PlaceType.museum),
  Place('Отель 2', PlaceType.hotel),
  Place('Ресторан 2', PlaceType.restaurant),
  Place('Парк 1', PlaceType.park),
  Place('Музей 2', PlaceType.museum),
  Place('Другое 1', PlaceType.other),
  Place('Парк 2', PlaceType.park),
  Place('Кафе 2', PlaceType.cafe),
  Place('Другое 2', PlaceType.other),
];

class _SetShowcaseScreenState extends State<SetShowcaseScreen> {
  Set<PlaceType> _selected = {};

  late final Set<PlaceType> _usefulFilters;

  late final Set<PlaceType> _overridePlaces;

  @override
  void initState() {
    /// 1. Скрыть бесполезные фильтры в [_PlacesFilterWidget]

    _usefulFilters = _places.map((e) => e.type).toSet();

    /// 2. Попробовать покомбинировать фильтры с помощью
    /// слияний/обьединений и высветить только бесполензные фильтры/
    /// только полезные фильтры/все фильтры.

    _overridePlaces = PlaceType.values.toSet().intersection(_usefulFilters);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      title: 'Множество',
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverFilterBarDelegate(
              child: _PlacesFilterWidget(
                overridePlaces: _overridePlaces.toList(),
                onChanged: (selected) {
                  setState(() {
                    _selected = selected;
                  });
                },
              ),
            ),
          ),
          _PlacesListWidget(selected: _selected),
        ],
      ),
    );
  }
}

class SliverFilterBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverFilterBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 125;

  @override
  double get minExtent => 125;

  @override
  bool shouldRebuild(covariant SliverFilterBarDelegate oldDelegate) {
    return false;
  }
}

class _PlacesFilterWidget extends StatefulWidget {
  final ValueChanged<Set<PlaceType>> onChanged;

  final List<PlaceType>? overridePlaces;

  const _PlacesFilterWidget({
    required this.onChanged,
    this.overridePlaces,
  });

  @override
  State<_PlacesFilterWidget> createState() => _PlacesFilterWidgetState();
}

class _PlacesFilterWidgetState extends State<_PlacesFilterWidget> {
  final _selected = <PlaceType>{};

  @override
  Widget build(BuildContext context) {
    final filters = widget.overridePlaces ?? PlaceType.values;

    return Container(
      color: Colors.white,
      height: 125,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        itemCount: filters.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final current = filters[index];

          return InkWell(
            onTap: () {
              setState(() {
                if (_selected.contains(current)) {
                  _selected.remove(current);
                } else {
                  _selected.add(current);
                }
              });

              widget.onChanged(_selected);
            },
            child: SizedBox(
              width: 70,
              child: _PlaceTypeWidget(
                type: current,
                selected: _selected.contains(current),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PlacesListWidget extends StatelessWidget {
  const _PlacesListWidget({required this.selected});

  final Set<PlaceType> selected;

  @override
  Widget build(BuildContext context) {
    final places = selected.isEmpty ? _places : _places.where((element) => selected.contains(element.type)).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final place = places[index];

          return ListTile(
            title: Text(place.name),
            leading: Image.asset(
              place.type.assetPath,
              width: 40,
              height: 40,
            ),
          );
        },
        childCount: places.length,
      ),
    );
  }
}

class _PlaceTypeWidget extends StatelessWidget {
  final PlaceType type;

  final bool selected;

  const _PlaceTypeWidget({
    required this.type,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final placeType = Column(
      children: [
        Image.asset(
          type.assetPath,
          width: 40,
          height: 40,
        ),
        const SizedBox(height: 10),
        Text(
          type.name,
          textAlign: TextAlign.center,
        ),
      ],
    );

    if (!selected) return placeType;

    return Stack(
      children: [
        Center(child: placeType),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            'assets/images/selected.png',
            width: 15,
            height: 15,
          ),
        ),
      ],
    );
  }
}
