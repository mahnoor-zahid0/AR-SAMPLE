import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:permission_handler/permission_handler.dart';

@override
void initState() {
  super.initState();
  _requestPermissions();
}

void _requestPermissions() async {
  await Permission.camera.request();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Sample Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ARHomePage(),
    );
  }
}

class ARHomePage extends StatefulWidget {
  @override
  _ARHomePageState createState() => _ARHomePageState();
}

class _ARHomePageState extends State<ARHomePage> {
  ArCoreController? arCoreController;

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addSphere(controller);
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(color: Colors.blue);
    final sphere = ArCoreSphere(materials: [material], radius: 0.1);
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Sample'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }
}
