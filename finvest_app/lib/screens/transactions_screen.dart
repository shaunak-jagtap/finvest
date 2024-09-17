import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/transaction.dart';
import '../widgets/transaction_item.dart';
import 'transactions_filter_screen.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedCreditCard = 'Credit card •••• 3507';
  List<String> _activeFilters = ['Current month', 'Food & Dining'];
  List<Transaction> _filteredTransactions = [];
  String _sortBy = 'Date'; // Sort by options
  bool _isSearching = false; // To track whether we are in search mode
  TextEditingController _searchController = TextEditingController(); // To capture search input

  @override
  void initState() {
    super.initState();
    _applyFilters(); // Apply filters initially to load the correct transactions.
    _searchController.addListener(_onSearchChanged); // Listen for search input changes
  }

  @override
  void dispose() {
    _searchController.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search transactions...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54),
          ),
          style: TextStyle(color: Colors.black),
        )
            : Text('Transactions'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  // If closing the search, clear the search input
                  _searchController.clear();
                }
                _isSearching = !_isSearching; // Toggle search mode
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildCreditCardDropdown(),
              _buildFilterRow(), // One row with filters and sort by dropdown
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredTransactions.length,
                  itemBuilder: (context, index) {
                    return TransactionItem(transaction: _filteredTransactions[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCardDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCreditCard,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedCreditCard = newValue;
                _applyFilters(); // Re-apply filters when the card changes
              });
            }
          },
          items: [
            'Credit card •••• 3507',
            'Credit card •••• 1234',
            'Credit card •••• 5678',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Row with filters and sort dropdown
  Widget _buildFilterRow() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Sort by dropdown
          _buildSortByDropdown(),
          SizedBox(width: 8), // Gap between dropdown and chips
          // Filters in a horizontal scrollable row
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Filters', Icons.tune, () {
                      _navigateToFilterScreen();
                    }),
                    SizedBox(width: 8), // Gap between filter chips
                    ..._activeFilters.map((filter) => Row(
                      children: [
                        _buildFilterChip(filter, null, () {
                          setState(() {
                            _activeFilters.remove(filter);
                            _applyFilters(); // Re-apply filters when one is removed
                          });
                        }),
                        SizedBox(width: 8), // Add gap between each chip
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sort by dropdown
  Widget _buildSortByDropdown() {
    return DropdownButton<String>(
      value: _sortBy,
      icon: Icon(Icons.arrow_drop_down),
      underline: SizedBox(), // Remove underline
      onChanged: (String? newValue) {
        setState(() {
          _sortBy = newValue!;
          _applyFilters(); // Re-apply filters based on new sorting
        });
      },
      items: ['Date', 'Amount', 'Category'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildFilterChip(String label, IconData? icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        avatar: icon != null ? Icon(icon, size: 18, color: Colors.blue) : null,
        label: Text(label, style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.blue.withOpacity(0.1),
        deleteIcon: icon == null ? Icon(Icons.close, size: 18, color: Colors.blue) : null,
        onDeleted: icon == null ? onTap : null,
      ),
    );
  }

  void _onSearchChanged() {
    _applyFilters(); // Re-apply filters when search input changes
  }

  void _navigateToFilterScreen() async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true, // This allows the bottom sheet to expand to full height
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded corners for the top
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8, // 80% of the screen height
          child: TransactionsFilterScreen(initialActiveFilters: _activeFilters),
        );
      },
    );

    if (result != null) {
      setState(() {
        _activeFilters.remove(_activeFilters);
        _activeFilters = result;
        _applyFilters(); // Re-apply filters based on new selections
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredTransactions = mockTransactions.where((transaction) {
        // Filter by date range
        if (_activeFilters.contains('Current month')) {
          final startOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
          if (transaction.date.isBefore(startOfMonth)) {
            return false;
          }
        } else if (_activeFilters.contains('Last month')) {
          final now = DateTime.now();
          final startOfLastMonth = DateTime(now.year, now.month - 1, 1);
          final endOfLastMonth = DateTime(now.year, now.month, 1).subtract(Duration(seconds: 1));
          if (transaction.date.isBefore(startOfLastMonth) || transaction.date.isAfter(endOfLastMonth)) {
            return false;
          }
        } else if (_activeFilters.contains('This year')) {
          final startOfYear = DateTime(DateTime.now().year, 1, 1);
          if (transaction.date.isBefore(startOfYear)) {
            return false;
          }
        } else if (_activeFilters.contains('Previous year')) {
          final now = DateTime.now();
          final startOfLastYear = DateTime(now.year - 1, 1, 1);
          final endOfLastYear = DateTime(now.year, 1, 1).subtract(Duration(seconds: 1));
          if (transaction.date.isBefore(startOfLastYear) || transaction.date.isAfter(endOfLastYear)) {
            return false;
          }
        }

        // Filter by status
        if (_activeFilters.contains('Completed') && transaction.status != 'Completed') {
          return false;
        }
        if (_activeFilters.contains('Pending') && transaction.status != 'Pending') {
          return false;
        }

        // Filter by multiple categories
        final selectedCategories = _activeFilters.where((filter) => [
          'Other','Transfer','Investment','Income','Bills & Utility','Food & Dining', 'Gifts & Donations', 'Shopping', 'Electronics', 'Groceries', 'Health & Wellness', 'Transportation', 'Entertainment','Excluded', 'Auto & Transport', 'Travel & Lifestyle'
        ].contains(filter)).toList();

        if (selectedCategories.isNotEmpty && !selectedCategories.contains(transaction.category)) {
          return false;
        }

        // Filter by multiple transaction types (assuming transaction types are stored in description)
        final selectedTransactionTypes = _activeFilters.where((filter) => [
          'Buy', 'Sell', 'Deposit', 'Withdrawl'
        ].contains(filter)).toList();

        if (selectedTransactionTypes.isNotEmpty && !selectedTransactionTypes.contains(transaction.description)) {
          return false;
        }

        // Apply search filter if active
        if (_isSearching && _searchController.text.isNotEmpty) {
          String searchTerm = _searchController.text.toLowerCase();
          if (!transaction.description.toLowerCase().contains(searchTerm) &&
              !transaction.category.toLowerCase().contains(searchTerm) &&
              !transaction.amount.toString().contains(searchTerm)) {
            return false;
          }
        }

        return true;
      }).toList();

      // Sort the transactions (if applicable)
      _sortTransactions();
    });
  }

  void _sortTransactions() {
    switch (_sortBy) {
      case 'Date':
        _filteredTransactions.sort((a, b) => b.date.compareTo(a.date)); // Most recent first
        break;
      case 'Amount':
        _filteredTransactions.sort((a, b) => b.amount.compareTo(a.amount)); // Highest amount first
        break;
      case 'Category':
        _filteredTransactions.sort((a, b) => a.category.compareTo(b.category)); // Alphabetical by category
        break;
    }
  }
}
