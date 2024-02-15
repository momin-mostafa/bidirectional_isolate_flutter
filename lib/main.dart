import 'package:bidirectional_isolate_flutter/compute_test.dart' as comp;
import 'package:bidirectional_isolate_flutter/data_sharing.dart';
import 'package:bidirectional_isolate_flutter/persistant_thread.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return computeScreenUI;
    // return presistantExampleUI;
    // return bidirectionalUI;
  }

  Widget get computeScreenUI {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compute Screen UI"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Calculate Factorial'),
              onPressed: () async {
                //show a loading indicator
                showDialog(
                  context: context,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
                await comp.computeExample(context).then((value) {
                  Navigator.of(context).pop();
                });
              },
            ),
            ElevatedButton(
              child: const Text('Calculate Factorial without compute'),
              onPressed: () async {
                //show a loading indicator
                showDialog(
                  context: context,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
                num a = comp.calculateFactorial(5000);
                //close the loading indicator
                print(a);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget get presistantExampleUI => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Presistant Example UI"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Check log for output',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await persistantThread();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );

  Widget get bidirectionalUI => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Bidirectional Data Passing UI"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Data Sharing Example',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  receivePort.sendPort.send("Hello");
                },
                child: const Text("Send Hello to Main Thread"),
              ),
              ElevatedButton(
                onPressed: () {
                  sendPort.send("Hello From Isolate");
                },
                child: const Text("Send to Isolate"),
              ),
              TextButton(
                onPressed: () {
                  var myTask = Task(
                      "A Really Heavy Function", aReallyHeavyFunction, 500);
                  sendPort.send(myTask);
                },
                child: const Text("Send Heavy Function to Isolate"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await dataSharing();
          },
          tooltip: 'Start Isolate',
          label: const Text("Start Isolate"),
        ),
      );
}

int aReallyHeavyFunction(int value) {
  var result = 0;
  for (int i = 0; i < value; i++) {
    result += i;
    print(result);
  }
  return result;
}
