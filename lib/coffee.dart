import 'dart:math';

double _doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) ;
final random = Random();
final coffees = List.generate(
  names.length,
  (index) => Coffee(
    imageUrls: 'assets/images/${index + 1}.png',
    name: names[index],
    price: _doubleInRange(random, 3, 7),
  ),
);

class Coffee {
  final String name;
  final String imageUrls;
  final double price;
  Coffee({
    required this.name,
    required this.imageUrls,
    required this.price,
  });
}

final names = [
  'bir',
  'ikki',
  'uch',
  'tort',
  'besh',
  'olti',
  'yetti',
  'sakkiz',
  'toqqiz',
  'on',
  'on bir',
  'on ikki',
];
