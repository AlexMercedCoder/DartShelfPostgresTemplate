// This file is for testing the DB class

import 'package:shelfpeople/db/connection.dart';
import 'package:shelfpeople/models/sample_model.dart';

void main() async {
  final db = DB();
  await db.conn.open();
  final samplemodel = SampleModel(conn: db.conn);

  final results = await samplemodel.update(id: 2, name: "Steve");
  print(results);
  db.conn.close();
}
