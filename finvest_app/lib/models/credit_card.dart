class CreditCard {
  final String bankName;
  final String lastFourDigits;
  final double balance;
  final String cardType; // e.g., "Visa", "Mastercard", etc.
  final String cardColor; // This could be a hex color string or a named color
  final double creditLimit;
  final String cardholderName;

  CreditCard({
    required this.bankName,
    required this.lastFourDigits,
    required this.balance,
    this.cardType = '',
    this.cardColor = '',
    this.creditLimit = 0.0,
    this.cardholderName = '',
  });

  // You might want to add a factory constructor to create a CreditCard from JSON data
  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      bankName: json['bankName'] as String,
      lastFourDigits: json['lastFourDigits'] as String,
      balance: json['balance'] as double,
      cardType: json['cardType'] as String? ?? '',
      cardColor: json['cardColor'] as String? ?? '',
      creditLimit: json['creditLimit'] as double? ?? 0.0,
      cardholderName: json['cardholderName'] as String? ?? '',
    );
  }

  // You might also want to add a method to convert the CreditCard to JSON
  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'lastFourDigits': lastFourDigits,
      'balance': balance,
      'cardType': cardType,
      'cardColor': cardColor,
      'creditLimit': creditLimit,
      'cardholderName': cardholderName,
    };
  }

  // Helper method to get the masked card number
  String get maskedCardNumber {
    return '**** **** **** $lastFourDigits';
  }

  // Helper method to calculate available credit
  double get availableCredit {
    return creditLimit - balance;
  }
}

class CreditCardAccount {
  final String id;
  final String bankName;
  final String cardNumber;
  final double balance;
  final double limit;

  CreditCardAccount({
    required this.id,
    required this.bankName,
    required this.cardNumber,
    required this.balance,
    required this.limit,
  });

  // You might want to add a method to get the last four digits
  String get lastFourDigits {
    return cardNumber.substring(cardNumber.length - 4);
  }

  // And a method to get the masked card number
  String get maskedCardNumber {
    return '**** **** **** ${lastFourDigits}';
  }
}