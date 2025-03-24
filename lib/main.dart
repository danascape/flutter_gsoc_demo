import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter GSoC Demo'),
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
  bool _showImage = false;
  bool _isConnected = false;


void _checkConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  bool hasInternet = false;

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    hasInternet = true;
  } else {
    // Uhmm for some reason wired connection was not working on QEMU.
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasInternet = true;
      }
    } catch (e) {
      hasInternet = false;
    }
  }

  setState(() {
    _isConnected = hasInternet;
    _showImage = hasInternet;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Saalim Quadri',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkConnectivity,
              child: Text('Show Image'),
            ),
            SizedBox(height: 20),
            _showImage
                ? Image.network(
                    'https://picsum.photos/200',
                    width: 150,
                    height: 150,
                  )
                : _isConnected
                    ? Container()
                    : Text("No Internet Connection", style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}