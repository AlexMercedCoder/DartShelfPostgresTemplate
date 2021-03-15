import "./connection.dart";
import "../models/samplemodel.dart";

// This file is for testing the DB class

void main() async {
  var db = DB();
  await db.conn.open();
  var samplemodel = SampleModel(db.conn);

  var results = await samplemodel.update(2, name: "Steve");
  print(results);
  db.conn.close();
}