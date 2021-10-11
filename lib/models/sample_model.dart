import 'package:postgres/postgres.dart';

class SampleModel {
  final PostgreSQLConnection conn;
  final String table;

  SampleModel({
    required this.conn,
    this.table = "accounts",
  });

  Future<List<Map<String, dynamic>>> destroy({required int id}) async {
    await conn.query("DELETE FROM $table WHERE id=@id",
        substitutionValues: {"id": id});
    return await getAll();
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final results = await conn.query("SELECT * FROM $table");

    final list = <Map<String, dynamic>>[];

    for (final row in results) {
      list.add({"id": row[0], "name": row[1]});
    }

    return list;
  }

  Future<Map<String, dynamic>> getOne({required int id}) async {
    final results = await conn.query("SELECT * FROM $table WHERE id=@id",
        substitutionValues: {"id": id});

    final list = <Map<String, dynamic>>[];

    for (final row in results) {
      list.add({"id": row[0], "name": row[1]});
    }

    return list.first;
  }

  Future<List<Map<String, dynamic>>> insert({required String name}) async {
    await conn.query(
      "INSERT INTO $table (name) VALUES (@name)",
      substitutionValues: {"name": name},
    );
    return await getAll();
  }

  Future<List<Map<String, dynamic>>> update(
      {required int id, String? name}) async {
    await conn.query("UPDATE $table SET name=@name WHERE id=@id",
        substitutionValues: {"id": id, "name": name});
    return await getAll();
  }
}
