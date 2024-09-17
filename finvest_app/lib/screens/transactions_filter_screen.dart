import 'package:flutter/material.dart';

class TransactionsFilterScreen extends StatefulWidget {
  final List<String> initialActiveFilters;

  TransactionsFilterScreen({required this.initialActiveFilters});

  @override
  _TransactionsFilterScreenState createState() => _TransactionsFilterScreenState();
}

class _TransactionsFilterScreenState extends State<TransactionsFilterScreen> {
  late List<String> _activeFilters;
  String? _selectedDateRange; // Single select for date range
  String? _selectedStatus; // Single select for status

  @override
  void initState() {
    super.initState();
    _activeFilters = List.from(widget.initialActiveFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky header for the "Filters" title
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 60.0,
              maxHeight: 60.0,
              child: Container(
                color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Scrollable content (Date Range to Transaction Type)
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 14),
              _buildSectionTitle('Date range'),
              _buildSingleSelectChips(['All time', 'Current month', 'Last month', 'This year', 'Previous year'], _selectedDateRange, (String selected) {
                setState(() {
                  _selectedDateRange = selected;
                });
              }),
              SizedBox(height: 14),
              _buildSectionTitle('Status'),
              _buildSingleSelectChips(['All', 'Completed', 'Pending'], _selectedStatus, (String selected) {
                setState(() {
                  _selectedStatus = selected;
                });
              }),
              SizedBox(height: 14),
              _buildSectionTitle('Categories'),
              _buildMultiSelectChips([
                'All', 'Food & Dining', 'Housing', 'Auto & Transport', 'Health & Wellness', 'Entertainment',
                'Gifts & Donations', 'Bills & Utility', 'Travel & Lifestyle', 'Shopping', 'Income',
                'Investment', 'Transfer', 'Other', 'Excluded'
              ]),
              SizedBox(height: 14),
              _buildSectionTitle('Transaction type'),
              _buildMultiSelectChips(['All', 'Buy', 'Sell', 'Deposit', 'Withdrawl']),
              SizedBox(height: 14),
            ]),
          ),
          // Sticky footer for "Clear all" and "Apply" buttons
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 70.0,
              maxHeight: 70.0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _activeFilters.clear(); // Clear all filters
                          _selectedDateRange = null; // Clear date range
                          _selectedStatus = null; // Clear status
                        });
                      },
                      child: Text(
                        'Clear all',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle the Apply button logic here
                        if (_selectedDateRange != null) {
                          _activeFilters.add(_selectedDateRange!);
                        }
                        if (_selectedStatus != null) {
                          _activeFilters.add(_selectedStatus!);
                        }
                        Navigator.pop(context, _activeFilters); // Return the selected filters to the parent screen
                      },
                      child: Text('Apply'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Single select chip logic for Date Range and Status
  Widget _buildSingleSelectChips(List<String> options, String? selectedOption, Function(String) onSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: options.map((option) {
          bool isSelected = selectedOption == option;
          return ChoiceChip(
            label: Text(option),
            labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
            selected: isSelected,
            selectedColor: Colors.blue,
            onSelected: (selected) {
              if (selected) {
                onSelected(option); // Call the passed function to update the selected option
              }
            },
            backgroundColor: Colors.grey[200],
          );
        }).toList(),
      ),
    );
  }

  // Multi select chip logic for Categories and Transaction Types
  Widget _buildMultiSelectChips(List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: options.map((option) {
          bool isSelected = _activeFilters.contains(option);
          return FilterChip(
            label: Text(option),
            labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
            selected: isSelected,
            selectedColor: Colors.blue,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _activeFilters.add(option); // Add selected option
                } else {
                  _activeFilters.remove(option); // Remove deselected option
                }
              });
            },
            backgroundColor: Colors.grey[200],
          );
        }).toList(),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    // Compare custom properties to determine if rebuild is needed
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

