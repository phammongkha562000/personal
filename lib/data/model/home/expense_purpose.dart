// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExpensePurpose {
   int? id;
   String? name;
   double? totalExpense;
   int? idTotalIncome; //khóa ngoại
  ExpensePurpose({
    this.id,
    this.name,
    this.totalExpense,
    this.idTotalIncome,
  });

  ExpensePurpose copyWith({
    int? id,
    String? name,
    double? totalExpense,
    int? idTotalIncome,
  }) {
    return ExpensePurpose(
      id: id ?? this.id,
      name: name ?? this.name,
      totalExpense: totalExpense ?? this.totalExpense,
      idTotalIncome: idTotalIncome ?? this.idTotalIncome,
    );
  }
}
