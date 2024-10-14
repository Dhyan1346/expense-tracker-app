import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
const uuid= Uuid();
final formater=DateFormat.yMd();

enum Category{
  food,travel,work,leisure
}
const catergoryIcon={
  Category.food:Icons.lunch_dining,
  Category.travel:FontAwesomeIcons.plane,
  Category.leisure:Icons.movie,
  Category.work:Icons.work,
};


class Expense{
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

  String get formetterdate{
    return formater.format(date);
}


}
class ExpenseBucket{
  const ExpenseBucket({required this.category,required this.expenses});


  ExpenseBucket.forCatergory(List<Expense>allExpenses, this.category)
      : expenses=allExpenses.where( (expense)=>expense.category ==category).toList();//addtional consteuctor func
  final Category category;
  final List<Expense>expenses;

  double get totalExpenses{
    double sum=0;
    for(final expense in expenses){
      sum= sum+expense.amount;
    }


    return sum;

  }


}