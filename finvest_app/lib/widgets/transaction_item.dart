import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final bool isPending; // Add support for 'Pending' status

  TransactionItem({required this.transaction, this.isPending = false}); // Default false for pending

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yy, h:mm a'); // Updated date format for the UI

    return ListTile(
      leading: _getTransactionIcon(transaction), // Added an icon on the left
      title: Text(
        transaction.description,
        style: TextStyle(
          fontWeight: FontWeight.bold, // Bolder for the description
        ),
      ),
      subtitle: Text(
        '${dateFormat.format(transaction.date)} ${isPending ? " • Pending" : ""}', // Added pending status display
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      trailing: Text(
        '-\$${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent, // Red for negative amounts
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food & Dining':
        return Icons.fastfood;
      case 'Housing':
        return Icons.home;
      case 'Auto & Transport':
        return Icons.directions_car;
      case 'Health & Wellness':
        return Icons.health_and_safety;
      case 'Entertainment':
        return Icons.movie;
      case 'Gifts & Donations':
        return Icons.card_giftcard;
      case 'Bills & Utility':
        return Icons.receipt;
      case 'Travel & Lifestyle':
        return Icons.airplanemode_active;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Income':
        return Icons.attach_money;
      case 'Investment':
        return Icons.show_chart;
      case 'Transfer':
        return Icons.swap_horiz;
      case 'Other':
        return Icons.more_horiz;
      case 'Excluded':
        return Icons.block;
      case 'Apps & software':
        return Icons.computer;
      case 'Food & Dining':
        return Icons.restaurant;
      case 'Electronics':
        return Icons.devices;
      case 'Transportation':
        return Icons.train;
      default:
        return Icons.category; // Fallback icon for uncategorized items
    }
  }


  // Function to get an icon for transactions (customize as needed)
  Widget _getTransactionIcon(Transaction transaction) {
    return CircleAvatar(
      radius: 20.0, // Size for the icon
      backgroundColor: Colors.blueAccent.withOpacity(0.2), // Placeholder background color
      child: Icon(
        _getCategoryIcon(transaction.category),
        color: Colors.blueAccent,
      ),
    );
  }
}
