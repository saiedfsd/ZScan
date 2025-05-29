import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  Uint8List? createdCodeBytes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WriterWidget(
            messages: const Messages(createButton: 'Create Code'),
            onSuccess: (result, bytes) {
              setState(() {
                createdCodeBytes = bytes;
              });
            },
            onError: (error) {
              _showMessage(context, 'Error: $error');
            },
          ),
          if (createdCodeBytes != null) Image.memory((createdCodeBytes ?? Uint8List(0))),
          SizedBox(height: 16,),
          if (createdCodeBytes != null) TextButton.icon(
            onPressed: () {
              _shareBarcodeImage();
            },
            icon: Icon(Icons.share, color: Colors.green),
            label: Text('Share', style: TextStyle(color: Colors.green)),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _shareBarcodeImage() async {
    try {
      if (createdCodeBytes == null) return;

      try {
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/barcode.png').create();
        await file.writeAsBytes(createdCodeBytes!);

        await Share.shareXFiles([XFile(file.path)], text: 'ZScan');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to share barcode image.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to share barcode image.")));
    }
  }

}
