import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  void _toggleImage() async {
    var checkConn = await Connectivity().checkConnectivity();
    if (checkConn == ConnectivityResult.wifi) {
      setState(() {
        _isConnected = true;
        _showImage = true;
      });
    } else {
      setState(() {
        _isConnected = false;
        _showImage = false;
      });
    }
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
              onPressed: _toggleImage,
              child: Text('Show Image'),
            ),
            SizedBox(height: 20),
            _showImage
                ? Image.network(
                    'https://picsum.photos/200',
                    width: 150,
                    height: 150,
                  )
                : !_isConnected
                    ? Text("No Internet Connection", style: TextStyle(color: Colors.red))
                    : Container(),
          ],
        ),
      ),
    );
  }
}