class Filter {
  DateTime? startDate;
  DateTime? endDate;
  List<String>? categories;
  String? transactionType;

  Filter({
    this.startDate,
    this.endDate,
    this.categories,
    this.transactionType,
  });

  // Copy constructor
  Filter.from(Filter other) {
    startDate = other.startDate;
    endDate = other.endDate;
    categories = other.categories != null ? List.from(other.categories!) : null;
    transactionType = other.transactionType;
  }

  // Optional: Add a method to create an empty filter
  static Filter empty() {
    return Filter(
      categories: [],
    );
  }

  // Optional: Add a method to check if the filter is empty
  bool isEmpty() {
    return startDate == null &&
        endDate == null &&
        (categories == null || categories!.isEmpty) &&
        transactionType == null;
  }

  // Optional: Add a method to clear all filters
  void clear() {
    startDate = null;
    endDate = null;
    categories = null;
    transactionType = null;
  }
}