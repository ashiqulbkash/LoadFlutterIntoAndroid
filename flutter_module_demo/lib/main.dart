import 'package:flutter/material.dart';
import 'package:flutter_module_demo/pigeon_model_host_api.dart';
import 'pigeon_model_flutter_impl.dart';

/// Call this function from android/ios side to load the flutter view
@pragma("vm:entry-point")
void nativeLoad() async {
  WidgetsFlutterBinding.ensureInitialized();
  PigeonModelFlutter();
  runApp(const MyApp());
}

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PigeonModelApi _modelApi;
  Person? _person;

  @override
  void initState() {
    super.initState();

    _modelApi = PigeonModelApi();
    _getPerson();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Receiving data from native side
          ValueListenableBuilder(
              valueListenable: notifier,
              builder: (ctx, emp, _) {
                return Text("Employee Name ${emp?.name ?? "No Name"}");
              }),
          // Receiving ready data from native side
          Text("Person Name ${_person?.name ?? "No Name"}"),
          const SizedBox(
            height: 30,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/1.jpg'),
            radius: 100,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              // Sending data to native side
              _modelApi.activateSubmissionButton(true);
            },
            child: const Text("Click Here"),
          ),
        ],
      ),
    );
  }

  // Receiving ready data from native side
  void _getPerson() async {
    final person = await _modelApi.getPerson();
    setState(() {
      _person = person;
    });
  }
}
