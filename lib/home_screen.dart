import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = "Stop Service";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //call the foreground service
                FlutterBackgroundService().invoke('setAsForeground');
              },
              child: const Text("Foreground service"),
            ),
            ElevatedButton(
              onPressed: () {
                //call the background service
                FlutterBackgroundService().invoke('setAsBackground');
              },
              child: const Text("Background service"),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();

                if (isRunning) {
                  //stop the service
                  service.invoke("stopService");

                } else {
                  service.startService();

                }
                if(!isRunning){
                  text = "Start service";
                }
                else{
                  text = "Stop service";
                }
                setState(() {});
              },
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
