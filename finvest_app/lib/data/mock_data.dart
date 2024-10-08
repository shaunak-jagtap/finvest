import '../models/credit_card_account.dart';
import '../models/transaction.dart';

List<CreditCardAccount> mockCreditCards = [
  CreditCardAccount(
    id: '1',
    bankName: 'Wells Fargo',
    cardNumber: '**** **** **** 6372',
    balance: 23450.54,
    limit: 50000.00,
  ),
  CreditCardAccount(
    id: '2',
    bankName: 'City',
    cardNumber: '**** **** **** 6008',
    balance: 12000.93,
    limit: 50000.00,
  ),
  CreditCardAccount(
    id: '3',
    bankName: 'Chase',
    cardNumber: '**** **** **** 7628',
    balance: 24890.00,
    limit: 50000.00,
  ),
];
List<Transaction> mockTransactions = [
// Housing
  Transaction(
    id: 't28',
    accountId: '3',
    date: DateTime(2024, 9, 15, 10, 00),
    description: 'Rent Payment',
    category: 'Housing',
    amount: 1200.00,
    status: 'Completed',
  ),

// Auto & Transport
  Transaction(
    id: 't29',
    accountId: '3',
    date: DateTime(2024, 9, 20, 14, 45),
    description: 'Car Repair',
    category: 'Auto & Transport',
    amount: 350.00,
    status: 'Completed',
  ),

// Gifts & Donations
  Transaction(
    id: 't30',
    accountId: '3',
    date: DateTime(2024, 9, 25, 18, 00),
    description: 'Charity Donation',
    category: 'Gifts & Donations',
    amount: 100.00,
    status: 'Completed',
  ),

// Bills & Utility
  Transaction(
    id: 't31',
    accountId: '3',
    date: DateTime(2024, 9, 27, 09, 30),
    description: 'Electricity Bill',
    category: 'Bills & Utility',
    amount: 80.00,
    status: 'Completed',
  ),

// Travel & Lifestyle
  Transaction(
    id: 't32',
    accountId: '3',
    date: DateTime(2024, 9, 30, 11, 00),
    description: 'Flight Ticket',
    category: 'Travel & Lifestyle',
    amount: 400.00,
    status: 'Completed',
  ),

// Income
  Transaction(
    id: 't33',
    accountId: '3',
    date: DateTime(2024, 9, 28, 15, 30),
    description: 'Salary',
    category: 'Income',
    amount: 3000.00,
    status: 'Completed',
  ),

// Investment
  Transaction(
    id: 't34',
    accountId: '3',
    date: DateTime(2024, 9, 29, 12, 00),
    description: 'Stock Purchase',
    category: 'Investment',
    amount: 500.00,
    status: 'Completed',
  ),

// Transfer
  Transaction(
    id: 't35',
    accountId: '3',
    date: DateTime(2024, 9, 26, 17, 00),
    description: 'Bank Transfer',
    category: 'Transfer',
    amount: 1500.00,
    status: 'Completed',
  ),

// Other
  Transaction(
    id: 't36',
    accountId: '3',
    date: DateTime(2024, 9, 22, 16, 00),
    description: 'Miscellaneous Expense',
    category: 'Other',
    amount: 75.00,
    status: 'Completed',
  ),

// Excluded
  Transaction(
    id: 't37',
    accountId: '3',
    date: DateTime(2024, 9, 18, 14, 15),
    description: 'Excluded Transaction',
    category: 'Excluded',
    amount: 0.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't1',
    accountId: '3',
    date: DateTime(2024, 6, 22, 16, 25),
    description: 'Uber',
    category: 'Transportation',
    amount: 82.00,
    status: 'Pending',
  ),
  Transaction(
    id: 't2',
    accountId: '3',
    date: DateTime(2024, 6, 22, 16, 25),
    description: 'Starbucks',
    category: 'Food & Dining',
    amount: 110.00,
    status: 'Pending',
  ),
  Transaction(
    id: 't3',
    accountId: '3',
    date: DateTime(2024, 6, 22, 16, 25),
    description: 'Mc Donalds',
    category: 'Food & Dining',
    amount: 110.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't4',
    accountId: '3',
    date: DateTime(2024, 6, 22, 16, 25),
    description: 'Ikea',
    category: 'Shopping',
    amount: 110.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't5',
    accountId: '3',
    date: DateTime(2024, 6, 22, 16, 25),
    description: 'JBL technologies',
    category: 'Electronics',
    amount: 110.00,
    status: 'Completed',
  ),
  // July 2024
  Transaction(
    id: 't6',
    accountId: '3',
    date: DateTime(2024, 7, 1, 14, 15),
    description: 'Amazon',
    category: 'Shopping',
    amount: 50.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't7',
    accountId: '3',
    date: DateTime(2024, 7, 3, 10, 00),
    description: 'Netflix',
    category: 'Entertainment',
    amount: 13.99,
    status: 'Completed',
  ),
  Transaction(
    id: 't8',
    accountId: '3',
    date: DateTime(2024, 7, 4, 12, 30),
    description: 'Gym Membership',
    category: 'Health & Wellness',
    amount: 35.00,
    status: 'Pending',
  ),
  Transaction(
    id: 't9',
    accountId: '3',
    date: DateTime(2024, 7, 5, 11, 30),
    description: 'Mc Donalds',
    category: 'Food & Dining',
    amount: 15.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't10',
    accountId: '3',
    date: DateTime(2024, 7, 6, 15, 00),
    description: 'Apple Store',
    category: 'Electronics',
    amount: 1200.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't11',
    accountId: '3',
    date: DateTime(2024, 7, 8, 19, 20),
    description: 'Uber Eats',
    category: 'Food & Dining',
    amount: 22.50,
    status: 'Pending',
  ),
  Transaction(
    id: 't12',
    accountId: '3',
    date: DateTime(2024, 7, 10, 17, 10),
    description: 'Grocery Store',
    category: 'Groceries',
    amount: 90.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't13',
    accountId: '3',
    date: DateTime(2024, 7, 12, 14, 45),
    description: 'Spotify',
    category: 'Entertainment',
    amount: 9.99,
    status: 'Pending',
  ),
  // August 2024
  Transaction(
    id: 't14',
    accountId: '3',
    date: DateTime(2024, 8, 2, 11, 50),
    description: 'Gas Station',
    category: 'Transportation',
    amount: 60.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't15',
    accountId: '3',
    date: DateTime(2024, 8, 3, 14, 00),
    description: 'Movie Theater',
    category: 'Entertainment',
    amount: 18.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't16',
    accountId: '3',
    date: DateTime(2024, 8, 5, 9, 00),
    description: 'Mc Donalds',
    category: 'Food & Dining',
    amount: 10.00,
    status: 'Pending',
  ),
  Transaction(
    id: 't17',
    accountId: '3',
    date: DateTime(2024, 8, 7, 15, 30),
    description: 'Apple Store',
    category: 'Electronics',
    amount: 400.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't18',
    accountId: '3',
    date: DateTime(2024, 8, 10, 13, 00),
    description: 'Best Buy',
    category: 'Electronics',
    amount: 300.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't19',
    accountId: '3',
    date: DateTime(2024, 8, 15, 16, 00),
    description: 'Airbnb',
    category: 'Travel',
    amount: 250.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't20',
    accountId: '3',
    date: DateTime(2024, 8, 18, 18, 45),
    description: 'Lyft',
    category: 'Transportation',
    amount: 35.00,
    status: 'Pending',
  ),
  Transaction(
    id: 't21',
    accountId: '3',
    date: DateTime(2024, 8, 20, 20, 30),
    description: 'Target',
    category: 'Shopping',
    amount: 150.00,
    status: 'Completed',
  ),
  // September 2024
  Transaction(
    id: 't22',
    accountId: '3',
    date: DateTime(2024, 9, 1, 17, 25),
    description: 'Grocery Store',
    category: 'Groceries',
    amount: 200.00,
    status: 'Pending',
  ),
  Transaction(
    id: 't23',
    accountId: '3',
    date: DateTime(2024, 9, 3, 18, 45),
    description: 'Spotify',
    category: 'Entertainment',
    amount: 9.99,
    status: 'Completed',
  ),
  Transaction(
    id: 't24',
    accountId: '3',
    date: DateTime(2024, 9, 5, 12, 15),
    description: 'Uber Eats',
    category: 'Food & Dining',
    amount: 25.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't25',
    accountId: '3',
    date: DateTime(2024, 9, 6, 10, 00),
    description: 'Starbucks',
    category: 'Food & Dining',
    amount: 15.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't26',
    accountId: '3',
    date: DateTime(2024, 9, 10, 13, 20),
    description: 'Apple Store',
    category: 'Electronics',
    amount: 1500.00,
    status: 'Completed',
  ),
  Transaction(
    id: 't27',
    accountId: '3',
    date: DateTime(2024, 9, 12, 11, 00),
    description: 'Netflix',
    category: 'Entertainment',
    amount: 13.99,
    status: 'Pending',
  ),
];

// Additional data structures based on the app screenshots

Map<String, double> topCategories = {
  'Food & Dining': 5000.32,
  'Apps & Software': 2600.45,
  'Health & Wellness': 1400.94,
};

Map<String, dynamic> filters = {
  'dateRange': ['All time', 'Current month', 'Last month', 'This year', 'Previous year'],
  'status': ['All', 'Completed', 'Pending'],
  'categories': [
    'All', 'Food & Dining', 'Housing', 'Auto & Transport', 'Health & Wellness',
    'Entertinments', 'Gifts & Donations', 'Bills & Utility',
    'Travel & Lifestyle', 'Shopping', 'Income', 'Investment',
    'Transfer', 'Other', 'Excluded'
  ],
  'transactionType': ['All', 'Buy', 'Sell', 'Deposit', 'Withdrawl'],
};