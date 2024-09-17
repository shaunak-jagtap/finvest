class Transaction {
  final String id;
  final String accountId;
  final DateTime date;
  final String description;
  final String category;
  final double amount;
  final String status;

  Transaction({
    required this.id,
    required this.accountId,
    required this.date,
    required this.description,
    required this.category,
    required this.amount,
    required this.status,
  });

  // Example: Factory method to create Transaction from JSON (if needed)
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      accountId: json['accountId'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      category: json['category'],
      amount: json['amount'].toDouble(),
      status: json['status'],
    );
  }

  // Example: Method to convert Transaction to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'date': date.toIso8601String(),
      'description': description,
      'category': category,
      'amount': amount,
      'status': status,
    };
  }
}
