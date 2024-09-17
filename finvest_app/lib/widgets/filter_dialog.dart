import 'package:flutter/material.dart';
import '../models/filter.dart';

class FilterDialog extends StatefulWidget {
  final Filter filter;

  FilterDialog({required this.filter});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    _startDate = widget.filter.startDate;
    _endDate = widget.filter.endDate;
    _selectedCategories = widget.filter.categories ?? [];
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Groceries', 'Shopping', 'Food', 'Travel'];

    return AlertDialog(
      title: Text('Filter Transactions'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Start Date'),
              subtitle: Text(_startDate != null ? _startDate!.toLocal().toString().split(' ')[0] : ''),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, true),
            ),
            ListTile(
              title: Text('End Date'),
              subtitle: Text(_endDate != null ? _endDate!.toLocal().toString().split(' ')[0] : ''),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, false),
            ),
            Divider(),
            Text('Categories'),
            Column(
              children: categories.map((category) {
                return CheckboxListTile(
                  title: Text(category),
                  value: _selectedCategories.contains(category),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedCategories.add(category);
                      } else {
                        _selectedCategories.remove(category);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(widget.filter);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.filter.startDate = _startDate;
            widget.filter.endDate = _endDate;
            widget.filter.categories = _selectedCategories;
            Navigator.of(context).pop(widget.filter);
          },
          child: Text('Apply'),
        ),
      ],
    );
  }
}
