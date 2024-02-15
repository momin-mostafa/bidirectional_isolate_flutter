import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

Future<void> persistantThread() async {
  var recivePort = ReceivePort();

  Isolate isolate = await Isolate.spawn(
    (sendport) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        log("in isolate timer tick : ${timer.tick}", name: 'isolate');
        sendport.send(timer.tick);
        if (timer.tick == 5) timer.cancel();
      });
      // sendport.send(calculateFactorial(20000));
    },
    recivePort.sendPort,
    // onExit: recivePort.sendPort,
    // onError: recivePort.sendPort,
  );

  isolate.addOnExitListener(recivePort.sendPort, response: "onExit");

  ///reciver should be defiend here
  // await for (final msg in recivePort) {
  //   log('message from isolate : $msg', name: 'main');
  //   if (msg == 10) {
  //     log('revice port closed', name: 'main');
  //     recivePort.close();
  //   }
  // }

  recivePort.listen((msg) {
    log('message from isolate : $msg', name: 'main');
    if (msg == "onExit") {
      log('revice port closed', name: 'main');
      recivePort.close();
    }
  });

  // log('isolate closed', name: 'main');
}

// // A heavy task
// int calculateFactorial(int n) {
//   // This function does the heavy computation
//   int result = 1;
//   for (int i = 2; i <= n; i++) {
//     print(i);
//     result *= i;
//   }
//   log("result: $result", name: "compute result");
//   return result;
// }
