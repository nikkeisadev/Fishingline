import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Loading Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AssetLoadingScreen(),
    );
  }
}

class AssetLoadingScreen extends StatefulWidget {
  @override
  _AssetLoadingScreenState createState() => _AssetLoadingScreenState();
}

class _AssetLoadingScreenState extends State<AssetLoadingScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  Future<void> loadAssets() async {
    // Load your assets here
    await Future.delayed(Duration(seconds: 2)); // Simulating asset loading delay

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Loading Demo'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Loading indicator
            : Text('All assets loaded!'), // Display this when assets are loaded
      ),
    );
  }
}
