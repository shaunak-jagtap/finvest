import 'package:flutter/material.dart';
import '../models/credit_card_account.dart';

class CreditCardWidget extends StatelessWidget {
  final CreditCardAccount card;
  final VoidCallback onTap;
  final ImageProvider logo; // Added logo

  const CreditCardWidget({
    Key? key,
    required this.card,
    required this.onTap,
    required this.logo, // Required logo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Credit card logo
            CircleAvatar(
              backgroundImage: logo, // Display the logo here
              radius: 20.0, // Adjust the size of the logo
            ),
            SizedBox(width: 16), // Space between logo and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.bankName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Asset ••••${card.cardNumber.substring(card.cardNumber.length - 4)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Balance Amount
            Text(
              '\$${card.balance.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: card.balance < 0 ? Colors.red : Colors.black, // Red for negative balance
              ),
            ),
          ],
        ),
      ),
    );
  }
}
