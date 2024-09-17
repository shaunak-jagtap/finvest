import 'package:flutter/material.dart';
import '../models/credit_card_account.dart';
import 'package:intl/intl.dart'; // For date formatting

class CreditDetailScreen extends StatelessWidget {
  final CreditCardAccount card;

  CreditDetailScreen({required this.card});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yy, h:mm a'); // Date format for transactions
    double availableCredit = card.limit - card.balance; // Calculate available credit

    return Scaffold(
      appBar: AppBar(
        title: Text('${card.bankName} Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Credit Card Visual Representation
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card.bankName,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'VISA', // Assuming all cards are VISA; adjust as needed
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      '**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Total Due: \$${card.balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Buttons (Details, Rewards, Credits, Benefits)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton(Icons.info, 'Details'),
                  _buildOptionButton(Icons.card_giftcard, 'Rewards'),
                  _buildOptionButton(Icons.credit_card, 'Credits'),
                  _buildOptionButton(Icons.bento, 'Benefits'),
                ],
              ),
              SizedBox(height: 16),
              // Credit Limit Info
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Credit Limit',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$${availableCredit.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Spent: \$${card.balance.toStringAsFixed(2)}'),
                        Text('Total Limit: \$${card.limit.toStringAsFixed(2)}'),
                      ],
                    ),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: card.balance / card.limit,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Last updated from bank on ${dateFormat.format(DateTime.now())}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Top Categories Section
              Text(
                'Top Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3, // Example for 3 categories
                itemBuilder: (context, index) {
                  // Replace this with actual category data
                  return ListTile(
                    leading: Icon(Icons.category),
                    title: Text('Category $index'),
                    trailing: Text('-\$${(100 * (index + 1)).toStringAsFixed(2)}'),
                  );
                },
              ),
              SizedBox(height: 16),
              // Recent Transactions Section
              Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5, // Example for 5 transactions
                itemBuilder: (context, index) {
                  // Replace this with actual transaction data
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.shopping_cart),
                    ),
                    title: Text('Transaction $index'),
                    subtitle: Text('${dateFormat.format(DateTime.now())} • Pending'),
                    trailing: Text('-\$${(50 * (index + 1)).toStringAsFixed(2)}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build option buttons
  Widget _buildOptionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          radius: 25,
          child: Icon(
            icon,
            size: 28,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
