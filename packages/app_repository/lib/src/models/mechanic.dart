enum Services { mechanic }

class Mechanic {
  Mechanic({
    required this.id,
    this.name,
    this.rating,
    this.services,
  });
  final String id;
  final String? name;
  final double? rating;
  final List<Services>? services;

  factory Mechanic.fromMap(Map<String, dynamic> map) {
    return Mechanic(
      id: map['id'],
    );
  }
}
