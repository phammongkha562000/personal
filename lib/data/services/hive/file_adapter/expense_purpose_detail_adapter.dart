// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:personal_manager/data/model/home/expense_purpose_detail.dart';

class ExpensePurposeDetailAdapter extends TypeAdapter<ExpensePurposeDetail> {
  @override
  final int typeId;
  ExpensePurposeDetailAdapter(
    this.typeId,
  );

  @override
  ExpensePurposeDetail read(BinaryReader reader) {
    final item = ExpensePurposeDetail();
    item.id = reader.read();
    item.fee = reader.read();
    item.name = reader.read();
    item.memo = reader.read();
    item.idExpensePurpose = reader.read();
    item.dateTime = reader.read();
    return item;
  }

  @override
  void write(BinaryWriter writer, ExpensePurposeDetail obj) {
    writer.write(obj.id);
    writer.write(obj.fee);
    writer.write(obj.name);
    writer.write(obj.memo);
    writer.write(obj.idExpensePurpose);
    writer.write(obj.dateTime);
  }
}
