class Bin {
  final int? id;
  final double? latitude;
  final double? longtitude;
  final String? imageUrl;
  final String? createdAt;

  Bin({
    required this.id,
    required this.latitude,
    required this.longtitude,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Bin.fromJson(Map<String, dynamic> json) {
    return Bin(
      id: json['id'],
      latitude: json['latitude'],
      longtitude: json['longtitude'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'latitude': latitude,
        'longtitude': longtitude,
        'imageUrl': imageUrl,
        'createAt': createdAt,
      };
}
