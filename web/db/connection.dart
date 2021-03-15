import 'package:postgres/postgres.dart';
import 'dart:io' show Platform;

class DB {

  PostgreSQLConnection conn;

  DB(){
    Map<String, String> envVars = Platform.environment;
    var host = envVars["DB_HOST"] == null ? "localhost" : envVars["DB_HOST"];
    var port = envVars["DB_PORT"] == null ? 5432 : int.parse(envVars["DB_PORT"]);
    var database = envVars["DB_DATABASE"] == null ? "test5" : envVars["DB_DATABASE"];
    var username = envVars["DB_USERNAME"] == null ? "test5" : envVars["DB_USERNAME"];
    var password = envVars["DB_PASSWORD"] == null ? "test5" : envVars["DB_PASSWORD"];
    this.conn = PostgreSQLConnection(host, port, database, username: username, password: password);
  }
}

