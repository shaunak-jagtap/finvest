import 'package:flutter/material.dart';
import '../models/filter.dart';

class FilterScreen extends StatefulWidget {
  final Filter initialFilter;
  final List<String> activeFilters;

  FilterScreen({required this.initialFilter, required this.activeFilters});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late Filter filter;
  late List<String> activeFilters;

  @override
  void initState() {
    super.initState();
    filter = Filter.from(widget.initialFilter);
    activeFilters = List.from(widget.activeFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          TextButton(
            child: Text('Apply', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.pop(context, filter);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildDateRangeSection(),
          _buildStatusSection(),
          _buildCategoriesSection(),
          _buildTransactionTypeSection(),
        ],
      ),
    );
  }

  Widget _buildDateRangeSection() {
    return ListTile(
      title: Text('Date range'),
      subtitle: Text(_getDateRangeText()),
      trailing: Icon(Icons.chevron_right),
      onTap: () async {
        final result = await showDialog<String>(
          context: context,
          builder: (BuildContext context) => _DateRangeDialog(
            initialSelection: _getDateRangeText(),
          ),
        );
        if (result != null) {
          setState(() {
            _updateDateRange(result);
          });
        }
      },
    );
  }

  String _getDateRangeText() {
    if (filter.startDate == null || filter.endDate == null) {
      return 'All time';
    } else if (filter.startDate!.isAfter(DateTime.now().subtract(Duration(days: 30)))) {
      return 'Current month';
    } else {
      return 'Custom range';
    }
  }

  void _updateDateRange(String selection) {
    switch (selection) {
      case 'All time':
        filter.startDate = null;
        filter.endDate = null;
        break;
      case 'Current month':
        filter.startDate = DateTime.now().subtract(Duration(days: 30));
        filter.endDate = DateTime.now();
        break;
      case 'Custom range':
      // Implement custom date range picker
        break;
    }
  }

  Widget _buildStatusSection() {
    return ListTile(
      title: Text('Status'),
      subtitle: Text(_getStatusText()),
      trailing: Icon(Icons.chevron_right),
      onTap: () async {
        final result = await showDialog<List<String>>(
          context: context,
          builder: (BuildContext context) => _StatusDialog(
            initialStatus: _getSelectedStatuses(),
          ),
        );
        if (result != null) {
          setState(() {
            _updateStatus(result);
          });
        }
      },
    );
  }

  String _getStatusText() {
    List<String> statuses = _getSelectedStatuses();
    if (statuses.isEmpty || statuses.length == 2) {
      return 'All';
    } else {
      return statuses.first;
    }
  }

  List<String> _getSelectedStatuses() {
    return ['Completed', 'Pending'].where((status) => activeFilters.contains(status)).toList();
  }

  void _updateStatus(List<String> selectedStatuses) {
    activeFilters.removeWhere((filter) => filter == 'Completed' || filter == 'Pending');
    activeFilters.addAll(selectedStatuses);
  }

  Widget _buildCategoriesSection() {
    return ListTile(
      title: Text('Categories'),
      subtitle: Text(filter.categories?.isNotEmpty == true ? filter.categories!.join(', ') : 'All'),
      trailing: Icon(Icons.chevron_right),
      onTap: () async {
        final result = await Navigator.push<List<String>>(
          context,
          MaterialPageRoute(builder: (context) => CategoriesScreen(initialCategories: filter.categories ?? [])),
        );
        if (result != null) {
          setState(() {
            filter.categories = result;
          });
        }
      },
    );
  }

  Widget _buildTransactionTypeSection() {
    return ListTile(
      title: Text('Transaction type'),
      subtitle: Text(filter.transactionType ?? 'All'),
      trailing: Icon(Icons.chevron_right),
      onTap: () async {
        final result = await showDialog<String>(
          context: context,
          builder: (BuildContext context) => _TransactionTypeDialog(
            initialType: filter.transactionType,
          ),
        );
        if (result != null) {
          setState(() {
            filter.transactionType = result == 'All' ? null : result;
          });
        }
      },
    );
  }
}

class _DateRangeDialog extends StatelessWidget {
  final String initialSelection;

  _DateRangeDialog({required this.initialSelection});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Select Date Range'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 'All time'),
          child: Text('All time'),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 'Current month'),
          child: Text('Current month'),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 'Custom range'),
          child: Text('Custom range'),
        ),
      ],
    );
  }
}

class _StatusDialog extends StatefulWidget {
  final List<String> initialStatus;

  _StatusDialog({required this.initialStatus});

  @override
  __StatusDialogState createState() => __StatusDialogState();
}

class __StatusDialogState extends State<_StatusDialog> {
  late List<String> selectedStatuses;

  @override
  void initState() {
    super.initState();
    selectedStatuses = List.from(widget.initialStatus);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Status'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text('Completed'),
            value: selectedStatuses.contains('Completed'),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedStatuses.add('Completed');
                } else {
                  selectedStatuses.remove('Completed');
                }
              });
            },
          ),
          CheckboxListTile(
            title: Text('Pending'),
            value: selectedStatuses.contains('Pending'),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedStatuses.add('Pending');
                } else {
                  selectedStatuses.remove('Pending');
                }
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.pop(context, selectedStatuses),
        ),
      ],
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  final List<String> initialCategories;

  CategoriesScreen({required this.initialCategories});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late List<String> selectedCategories;
  final List<String> allCategories = [
    'Food & Dining', 'Shopping', 'Housing', 'Transportation',
    'Vehicle', 'Life & Entertainment', 'Communication, PC',
    'Financial expenses', 'Investments', 'Income', 'Other'
  ];

  @override
  void initState() {
    super.initState();
    selectedCategories = List.from(widget.initialCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Categories'),
        actions: [
          TextButton(
            child: Text('Apply', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.pop(context, selectedCategories);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          final category = allCategories[index];
          return CheckboxListTile(
            title: Text(category),
            value: selectedCategories.contains(category),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedCategories.add(category);
                } else {
                  selectedCategories.remove(category);
                }
              });
            },
          );
        },
      ),
    );
  }
}

class _TransactionTypeDialog extends StatelessWidget {
  final String? initialType;

  _TransactionTypeDialog({this.initialType});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Select Transaction Type'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 'All'),
          child: Text('All'),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 'Income'),
          child: Text('Income'),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 'Expense'),
          child: Text('Expense'),
        ),
      ],
    );
  }
}