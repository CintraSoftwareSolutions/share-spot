class FavoriteLocation {
  const FavoriteLocation({
    required this.name,
    required this.address,
    required this.arrivalTime,
    required this.reliability,
    required this.image,
    this.isCritical = false,
  });

  final String name;
  final String address;
  final String arrivalTime;
  final String reliability;
  final String image;
  final bool isCritical;
}
