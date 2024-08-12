import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ArPage extends StatefulWidget {
  final String? imageUrl;

  const ArPage({Key? key, this.imageUrl}) : super(key: key);

  @override
  _ArPageState createState() => _ArPageState();
}

class _ArPageState extends State<ArPage> {
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Obtain a list of available cameras.
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      // Initialize the CameraController with the first camera.
      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.yuv420, // Choose a supported format.
      );

      // Initialize the controller and store the future.
      _initializeControllerFuture = _cameraController.initialize();

      // Update the state once initialization is complete.
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View in AR")),
      body: _initializeControllerFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  return Stack(
                    children: [
                      CameraPreview(_cameraController),
                      if (widget.imageUrl != null)
                        Positioned(
                          top: 100, // Adjust as needed
                          left: 100, // Adjust as needed
                          child: Container(
                            width: 200, // Adjust size as needed
                            height: 200, // Adjust size as needed
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
