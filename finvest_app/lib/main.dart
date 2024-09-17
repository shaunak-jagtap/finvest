import 'package:flutter/material.dart';
import 'screens/credit_card_listing_screen.dart';

void main() {
  runApp(FinvestApp());
}

class FinvestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finvest App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreditCardListingScreen(),
    );
  }
}
