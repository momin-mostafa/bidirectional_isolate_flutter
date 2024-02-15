// import 'dart:developer';
import 'dart:developer';
import 'dart:isolate';

final receivePort = ReceivePort();
late SendPort sendPort;

Future<void> dataSharing() async {
  log("dataSharing start");
  Isolate isolate = await Isolate.spawn(_isolate, [receivePort.sendPort]);

  isolate.addOnExitListener(receivePort.sendPort, response: 'Exit');

  receivePort.listen((message) {
    if (message is SendPort) {
      sendPort = message;
    } else if (message is String) {
      if (message == 'Exit') {
        log("Isolate Exited Successfully", name: "Isolate");
      }
      log("message from main thread: $message");
    } else if (message is Task) {
      sendPort.send(message);
      log("message from main thread: $message");
    }
    if (message is TaskResult) {
      log("Task Name: ${message.name}", name: "TASK");
      log("Task Result: ${message.result}", name: "TASK");
    }
  });
}

_isolate(v) {
  log("isolate start");
  sendPort = v[0] as SendPort;

  sendPort.send(receivePort.sendPort);

  receivePort.listen((message) {
    if (message is String) {
      print("message from isolate: $message");
    }
    if (message is Task) {
      print("message from isolate: ${message.name}");
      var resultOfMethod = message.method(message.args);

      var result = TaskResult(message.name, resultOfMethod);
      log(result.result.toString(), name: result.name);
      sendPort.send(result);
    }
  });
}

class Task {
  String name;

  Function method;
  dynamic args;

  Task(this.name, this.method, this.args);
}

class TaskResult {
  String name;
  dynamic result;

  TaskResult(this.name, this.result);
}
