import "./samplemodel.dart";
import "../db/connection.dart";

Future<SampleModel> model () async {
var db = DB();
await db.conn.open();
return SampleModel(db.conn);
}
