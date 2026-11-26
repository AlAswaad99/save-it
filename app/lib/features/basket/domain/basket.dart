/// The local basket. It survives a restart and a logout.
class Basket {
  const Basket({this.restaurantId, this.lines = const []});

  const Basket.empty() : restaurantId = null, lines = const [];

  final String? restaurantId;
  final List<BasketLine> lines;

  bool get isEmpty => lines.isEmpty;

  Map<String, Object?> toJson() => {
    'restaurant_id': restaurantId,
    'lines': lines.map((line) => line.toJson()).toList(),
  };

  factory Basket.fromJson(Map<String, Object?> json) {
    final rawLines = json['lines'];
    final lines = <BasketLine>[];
    if (rawLines is List) {
      for (final raw in rawLines) {
        if (raw is Map) {
          lines.add(BasketLine.fromJson(raw.cast<String, Object?>()));
        }
      }
    }
    return Basket(
      restaurantId: json['restaurant_id'] as String?,
      lines: lines,
    );
  }
}

class BasketLine {
  const BasketLine({
    required this.listingId,
    required this.qty,
    required this.name,
    required this.price,
  });

  final String listingId;
  final int qty;
  final String name;

  /// AED amount as stored, for example `12.50`.
  final String price;

  Map<String, Object?> toJson() => {
    'listing_id': listingId,
    'qty': qty,
    'name': name,
    'price': price,
  };

  factory BasketLine.fromJson(Map<String, Object?> json) {
    return BasketLine(
      listingId: json['listing_id'] as String? ?? '',
      qty: json['qty'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      price: json['price'] as String? ?? '0.00',
    );
  }
}
