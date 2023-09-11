// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExpensePurpose {
  final int? id;
  final String? name;
  final double? totalExpense;
  final int? idTotalIncome; //khóa ngoại
  ExpensePurpose({
    this.id,
    this.name,
    this.totalExpense,
    this.idTotalIncome,
  });
}
