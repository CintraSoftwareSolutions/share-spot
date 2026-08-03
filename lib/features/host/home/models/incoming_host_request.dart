class IncomingHostRequest {
  const IncomingHostRequest({
    required this.name,
    required this.rating,
    required this.distance,
    required this.match,
  });

  final String name;
  final String rating;
  final String distance;
  final int match;
}
