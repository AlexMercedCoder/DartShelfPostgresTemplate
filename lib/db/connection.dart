import 'dart:io' show Platform;

import 'package:postgres/postgres.dart';

class DB {
  late final PostgreSQLConnection conn;

  DB() {
    Map<String, String> envVars = Platform.environment;
    var host = envVars["DB_HOST"] ?? "localhost";
    var port =
        envVars["DB_PORT"] == null ? 5432 : int.parse(envVars["DB_PORT"]!);
    var database = envVars["DB_DATABASE"] ?? "test5";
    var username = envVars["DB_USERNAME"] ?? "test5";
    var password = envVars["DB_PASSWORD"] ?? "test5";
    conn = PostgreSQLConnection(
      host,
      port,
      database,
      username: username,
      password: password,
      useSSL: true, //for production
      //useSSL: false, //for local development
    );
  }
}
