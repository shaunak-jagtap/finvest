import 'package:finvest_app/models/credit_card.dart';
import 'package:flutter/material.dart';
import '../models/credit_card_account.dart';
class CreditCardItem extends StatelessWidget {
  final CreditCard card;
  final VoidCallback onTap;

  const CreditCardItem({Key? key, required this.card, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.bankName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '**** **** **** ${card.lastFourDigits}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              '\$${card.balance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}