enum DonationStatus { confirmed, pending, cancelled }

class DonationDetails {
  final String location;
  final DateTime date;
  final String type;
  final DonationStatus status;

  const DonationDetails({
    required this.location,
    required this.date,
    required this.type,
    required this.status,
  });
}