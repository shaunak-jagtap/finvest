import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String category;
  final double amount;
  final int percentage;
  final IconData icon; // Added icon
  final Color iconBackgroundColor; // Added icon background color

  const CategoryItem({
    Key? key,
    required this.category,
    required this.amount,
    required this.percentage,
    required this.icon, // Require icon
    required this.iconBackgroundColor, // Require background color for icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          // Category icon with background color
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBackgroundColor, // Use the passed background color
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon, // Use the passed icon
              color: Colors.white,
              size: 24.0,
            ),
          ),
          SizedBox(width: 16),
          // Category details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$percentage% of spends',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Amount (negative amount in red)
          Text(
            '-\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
