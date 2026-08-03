class ParkingDetailArguments {
  const ParkingDetailArguments({
    required this.destinationName,
    required this.arrivalTime,
    required this.successRate,
    this.mapLabel,
  });

  final String destinationName;
  final String arrivalTime;
  final String successRate;
  final String? mapLabel;

  String get resolvedMapLabel => mapLabel ?? destinationName;
}
