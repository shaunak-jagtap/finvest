import 'package:finvest_app/models/transaction.dart';
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/balance_graph.dart';
import '../widgets/credit_card.dart';
import '../widgets/category_item.dart';
import '../widgets/transaction_item.dart';
import 'credit_detail_screen.dart';
import 'transactions_screen.dart';

class CreditCardListingScreen extends StatefulWidget {
  @override
  _CreditCardListingScreenState createState() => _CreditCardListingScreenState();
}

class _CreditCardListingScreenState extends State<CreditCardListingScreen> {
  String selectedPeriod = '6M'; // State variable for selected period
  Map<DateTime, double> getSpendingByPeriod(String period, List<Transaction> transactions) {
    Map<DateTime, double> spendingMap = {};

    DateTime now = DateTime.now(); // Get the current date and time

    for (var transaction in transactions) {
      DateTime transactionDate = transaction.date;

      switch (period) {
        case '1W': // Filter for transactions within the last 7 days
          if (transactionDate.isAfter(now.subtract(Duration(days: 7))) && transactionDate.isBefore(now)) {
            _accumulateSpending(spendingMap, transactionDate, transaction.amount);
          }
          break;
        case '1M': // Filter for transactions within the last 30 days
          if (transactionDate.isAfter(now.subtract(Duration(days: 30)))) {
            _accumulateSpending(spendingMap, transactionDate, transaction.amount);
          }
          break;
        case '3M': // Filter for transactions within the last 90 days
          if (transactionDate.isAfter(now.subtract(Duration(days: 90)))) {
            _accumulateSpending(spendingMap, transactionDate, transaction.amount);
          }
          break;
        case '6M':
          if (transactionDate.isAfter(now.subtract(Duration(days: 180)))) {
            _accumulateSpending(spendingMap, transactionDate, transaction.amount);
          }
          break;
        case 'YTD':
          if (transactionDate.year == now.year) {
            _accumulateSpending(spendingMap, transactionDate, transaction.amount);
          }
          break;
        case '1Y':
          if (transactionDate.isAfter(now.subtract(Duration(days: 365)))) {
            _accumulateSpending(spendingMap, transactionDate, transaction.amount);
          }
          break;
        case 'ALL':
          _accumulateSpending(spendingMap, transactionDate, transaction.amount);
          break;
      }
    }

    return spendingMap;
  }

// Helper function to accumulate spending by date
  void _accumulateSpending(Map<DateTime, double> map, DateTime date, double amount) {
    DateTime dateKey = DateTime(date.year, date.month, date.day); // Aggregate by day
    if (!map.containsKey(dateKey)) {
      map[dateKey] = 0;
    }
    map[dateKey] = map[dateKey]! + amount;
  }


  @override
  Widget build(BuildContext context) {
    double totalBalance = mockCreditCards.fold(
      0,
          (sum, card) => sum + card.balance,
    );

    // Get the spending data for the graph based on the selected period
    Map<DateTime, double> spendingData = getSpendingByPeriod(selectedPeriod, mockTransactions);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
        title: Text('Credit card', style: TextStyle(fontSize: 20.0)),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, size: 24.0),
            onPressed: () {
              // Show info about credit cards
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BALANCE DUE',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[500]),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '\$${totalBalance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
              // Balance Graph with Period Selector
              BalanceGraph(
                totalBalance: totalBalance,
                selectedPeriod: selectedPeriod,
                onPeriodSelected: (period) {
                  // Update selectedPeriod when a new period is tapped
                  setState(() {
                    selectedPeriod = period;
                  });
                },
                spendingData: spendingData, // Pass the spending data
              ),
              SizedBox(height: 8.0),
              // Credit cards section
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:16.0),
                     child: Text(
                       'Credit cards',
                       style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                     ),
                   ),
                   SizedBox(height: 8.0),
                   ListView.builder(
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: mockCreditCards.length,
                     itemBuilder: (context, index) {
                       return Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: CreditCardWidget(
                           card: mockCreditCards[index],
                           logo: _getCreditCardLogo(mockCreditCards[index]),
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => CreditDetailScreen(
                                   card: mockCreditCards[index],
                                 ),
                               ),
                             );
                           },
                         ),
                       );
                     },
                   ),
                   // Add Account Button
                   Center(
                     child: TextButton(
                       onPressed: () {
                         // Handle add account functionality
                       },
                       child: Text('+ ADD ACCOUNT'),
                     ),
                   ),
                   SizedBox(height: 16.0),
                 ],),
               ),
             ),
              // Top Categories section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top categories',
                          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: topCategories.length,
                          itemBuilder: (context, index) {
                            String category = topCategories.keys.elementAt(index);
                            double amount = topCategories[category]!;
                            return CategoryItem(
                              category: category,
                              amount: amount,
                              percentage: (amount / totalBalance * 100).round(),
                              icon: _getCategoryIcon(category),
                              iconBackgroundColor: _getCategoryColor(category),
                            );
                          },
                        ),
                        Center(
                          child: TextButton(
                            child: Text('SEE ALL CATEGORIES'),
                            onPressed: () {

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // All Transactions section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All transactions',
                          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5, // Show only the last 5 transactions
                          itemBuilder: (context, index) {
                            return TransactionItem(
                              transaction: mockTransactions[index],
                              isPending: mockTransactions[index].status == 'Pending',
                            );
                          },
                        ),
                        SizedBox(height: 8.0),
                        Center(
                          child: TextButton(
                            child: Text('SEE ALL TRANSACTIONS'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionsScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to get icons for categories
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
      case 'Apps & Software':
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


  // Helper to get background color for category icons
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food & dining':
        return Colors.blue;
      case 'Apps & software':
        return Colors.amber;
      case 'Health & wellness':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  // Helper to get logos for credit cards
  ImageProvider _getCreditCardLogo(card) {
    switch (card.bankName) {
      case 'Wellsfargo Gold':
        return NetworkImage('https://via.placeholder.com/150'); // Placeholder image for Wellsfargo
      case 'City Platinum':
        return NetworkImage('https://via.placeholder.com/150'); // Placeholder image for Citi
      default:
        return NetworkImage('https://via.placeholder.com/150'); // Default placeholder image
    }
  }
}
