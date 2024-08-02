class Plan {
  final int id;
  final String year;
  final String planType;
  final int month;
  final String purpose;
  final double amount;
  final bool status;

  Plan({
    required this.id,
    required this.year,
    required this.planType,
    required this.month,
    required this.purpose,
    required this.amount,
    required this.status,
  });
}
