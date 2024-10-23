import '../database.dart';

class FotoTable extends SupabaseTable<FotoRow> {
  @override
  String get tableName => 'foto';

  @override
  FotoRow createRow(Map<String, dynamic> data) => FotoRow(data);
}

class FotoRow extends SupabaseDataRow {
  FotoRow(super.data);

  @override
  SupabaseTable get table => FotoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);
}
