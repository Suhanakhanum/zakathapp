class PaymentEntry {
  final String date;
  final double paidAmount;
  final String paidFrom;
  final String paidTo;
  final String debitedFrom;
  final bool paid_status;
  final int planId;

  PaymentEntry({
    required this.date,
    required this.paidAmount,
    required this.paidFrom,
    required this.paidTo,
    required this.debitedFrom,
    required this.paid_status,
    required this.planId
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'paid_amount': paidAmount,
      'paid_from': paidFrom,
      'paid_to': paidTo,
      'debited_from': debitedFrom,
      'paid_status':paid_status,
      'plan_Id':planId
    };
  }
}