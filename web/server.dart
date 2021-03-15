// import 'dart:async' show Future;
// import 'package:shelf_router/shelf_router.dart';
// import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import './controllers/HomeController.dart';
import 'dart:io' show Platform;

void main() async {
  // Variable for PORT
  Map<String, String> envVars = Platform.environment;
  var portEnv = envVars['PORT'];
  var PORT = portEnv == null ? 7777 : int.parse(portEnv);
  //Instantiate Home Controller
  final home = HomeController();
  // Create server
  final server = await shelf_io.serve(home.handler, '0.0.0.0', PORT);
  // Server on message
  print('☀️ Server running on localhost:${server.port} ☀️');
}