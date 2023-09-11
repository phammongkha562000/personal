import 'package:hive/hive.dart';

import '../../../model/home/total_income.dart';

class TotalIncomeAdapter extends TypeAdapter<TotalIncome> {
  @override
  final int typeId;

  TotalIncomeAdapter(this.typeId);

  @override
  TotalIncome read(BinaryReader reader) {
    final item = TotalIncome();
    item.id = reader.read();
    item.totalIncome = reader.read();
    item.dateTime = reader.read();

    return item;
  }

  @override
  void write(BinaryWriter writer, TotalIncome obj) {
    writer.write(obj.id);
    writer.write(obj.totalIncome);
    writer.write(obj.dateTime);
  }
}
