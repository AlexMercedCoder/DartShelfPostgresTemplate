// import "../db/connection.dart";
import 'package:postgres/postgres.dart';

class SampleModel {

  PostgreSQLConnection conn;
  String table;

  SampleModel(conn){
    this.conn = conn;
    this.table = "test";
  }

  insert({String name}) async {
    List<List<dynamic>> results = await this.conn.query("INSERT INTO ${this.table} (name) VALUES (@name)", substitutionValues: {
      "name": name
    });
    return await this.getAll();
  }

    getAll() async {
    List<List<dynamic>> results = await this.conn.query("SELECT * FROM ${this.table}");

    List<Map <String, dynamic>> list = [];

    for (final row in results){
      list.add({
        "id": row[0],
        "name": row[1]
      });

    };
    return list;
  }

    getOne(int id) async {
    List<List<dynamic>> results = await this.conn.query("SELECT * FROM ${this.table} WHERE id=@id", substitutionValues: {
      "id": id
    });

    List<Map <String, dynamic>> list = [];

    for (final row in results){
      list.add({
        "id": row[0],
        "name": row[1]
      });}

    return list[0];
  }

    update(int id, {String name}) async {
    List<List<dynamic>> results = await this.conn.query("UPDATE ${this.table} SET name=@name WHERE id=@id", substitutionValues: {
      "id": id,
      "name": name
    });
    return await this.getAll();
  }

    destroy(int id) async {
    List<List<dynamic>> results = await this.conn.query("DELETE FROM ${this.table} WHERE id=@id", substitutionValues: {
      "id": id
    });
    return await this.getAll();
  }
}