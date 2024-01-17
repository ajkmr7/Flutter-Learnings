import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  debtRepayment,
  groceries,
  household,
  hospital,
  movie,
  telecom,
  rent,
  transport,
  miscallaneous,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.debtRepayment: Icons.money,
  Category.groceries: Icons.local_grocery_store,
  Category.household: Icons.chair,
  Category.hospital: Icons.local_pharmacy,
  Category.movie: Icons.movie,
  Category.telecom: Icons.phone,
  Category.rent: Icons.house,
  Category.transport: Icons.emoji_transportation,
  Category.miscallaneous: Icons.miscellaneous_services,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate => dateFormatter.format(date);
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
