import 'package:shelfpeople/db/connection.dart';
import 'package:shelfpeople/models/sample_model.dart';

Future<SampleModel> model() async {
  final db = DB();
  await db.conn.open();
  return SampleModel(conn: db.conn);
}
