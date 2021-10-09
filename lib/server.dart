import 'dart:io' show Platform;

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelfpeople/controllers/home_controller.dart';

void main() async {
  // Variable for PORT
  Map<String, String> envVars = Platform.environment;
  var portEnv = envVars['PORT'];
  final port = portEnv == null ? 7777 : int.parse(portEnv);
  //Instantiate Home Controller
  final home = HomeController();
  // Create server
  final server = await shelf_io.serve(home.handler, '0.0.0.0', port);
  // Server on message
  print('☀️ Server running on localhost:${server.port} ☀️');
}
