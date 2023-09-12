// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:personal_manager/data/model/home/expense_purpose.dart';

class ExpensePurposeAdapter extends TypeAdapter<ExpensePurpose> {
  @override
  final int typeId;
  ExpensePurposeAdapter(
    this.typeId,
  );

  @override
  ExpensePurpose read(BinaryReader reader) {
    final item = ExpensePurpose();
    item.id = reader.read();
    item.name = reader.read();
    item.totalExpense = reader.read();
    item.idTotalIncome = reader.read();
    return item;
  }

  @override
  void write(BinaryWriter writer, ExpensePurpose obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.totalExpense);
    writer.write(obj.idTotalIncome);
  }
}
