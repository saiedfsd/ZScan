import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zscan/database/db_helper.dart';

import 'debug_info_widget.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  Uint8List? createdCodeBytes;

  Code? result;
  Codes? multiResult;
  bool dialogOnShow = false;
  bool isMultiScan = false;

  bool showDebugInfo = false;
  int successScans = 0;
  int failedScans = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ReaderWidget(
          onScan: _onScanSuccess,
          onScanFailure: _onScanFailure,
          onMultiScan: _onMultiScanSuccess,
          onMultiScanFailure: _onMultiScanFailure,
          onMultiScanModeChanged: _onMultiScanModeChanged,
          onControllerCreated: _onControllerCreated,
          isMultiScan: isMultiScan,
          verticalCropOffset: -0.7,
          horizontalCropOffset: 0,
          tryInverted: true,
          tryDownscale: true,
          maxNumberOfSymbols: 5,
          scanDelay: Duration(milliseconds: isMultiScan ? 50 : 500),
          resolution: ResolutionPreset.high,
          lensDirection: CameraLensDirection.back,
          flashOnIcon: const Icon(Icons.flash_on),
          flashOffIcon: const Icon(Icons.flash_off),
          flashAlwaysIcon: const Icon(Icons.flash_on),
          flashAutoIcon: const Icon(Icons.flash_auto),
          galleryIcon: const Icon(Icons.photo_library),
          toggleCameraIcon: const Icon(Icons.switch_camera),
          actionButtonsBackgroundBorderRadius: BorderRadius.circular(10),
          actionButtonsBackgroundColor: Colors.black.withValues(alpha: 0.5),
        ),
        if (showDebugInfo)
          DebugInfoWidget(
            successScans: successScans,
            failedScans: failedScans,
            error: isMultiScan ? multiResult?.error : result?.error,
            duration: isMultiScan ? multiResult?.duration ?? 0 : result?.duration ?? 0,
            onReset: _onReset,
            imageBytes: !isMultiScan && result?.imageBytes != null
                ? pngFromBytes(result?.imageBytes ?? Uint8List(0), result?.imageWidth ?? 0, result?.imageHeight ?? 0)
                : null,
          ),
      ],
    );
  }

  void _onControllerCreated(_, Exception? error) {
    if (error != null) {
      // Handle permission or unknown errors
      _showMessage(context, 'Error: $error');
    }
  }

  _onScanSuccess(Code? code) {
    setState(() {
      successScans++;
      result = code;
    });
    if (!dialogOnShow) _showScanResultDialog(context, result!.text!);
  }

  _onScanFailure(Code? code) {
    setState(() {
      failedScans++;
      result = code;
    });
    if (code?.error?.isNotEmpty == true) {
      _showMessage(context, 'Error: ${code?.error}');
    }
  }

  _onMultiScanSuccess(Codes codes) {
    setState(() {
      successScans++;
      multiResult = codes;
    });
  }

  _onMultiScanFailure(Codes result) {
    setState(() {
      failedScans++;
      multiResult = result;
    });
    if (result.codes.isNotEmpty == true) {
      _showMessage(context, 'Error: ${result.codes.first.error}');
    }
  }

  _onMultiScanModeChanged(bool isMultiScan) {
    setState(() {
      this.isMultiScan = isMultiScan;
    });
  }

  _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  _onReset() {
    setState(() {
      successScans = 0;
      failedScans = 0;
    });
  }

  void _showScanResultDialog(BuildContext context, String result) {
    dialogOnShow = true;
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            setState(() {
              dialogOnShow = false;
            });
            return true;
          },
          child: AlertDialog(
            title: Text(
              'Scan Result',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            backgroundColor: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(result, textAlign: TextAlign.start, style: TextStyle(fontSize: 16)),
            ),
            actionsPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    dialogOnShow = false;
                  });
                  _copyToClipboard(result);
                },
                icon: Icon(Icons.copy, color: Colors.blue),
                label: Text('Copy', style: TextStyle(color: Colors.blue)),
                style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    dialogOnShow = false;
                  });
                  _shareResult(result);
                },
                icon: Icon(Icons.share, color: Colors.green),
                label: Text('Share', style: TextStyle(color: Colors.green)),
                style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    dialogOnShow = false;
                  });
                  _saveResult(result);
                },
                icon: Icon(Icons.save, color: Colors.green.shade600),
                label: Text('Save', style: TextStyle(color: Colors.green.shade600)),
                style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _shareResult(String result) {
    Share.share(result);
  }

  void _copyToClipboard(String result) {
    Clipboard.setData(ClipboardData(text: result));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Barcode Copied!")));
  }

  void _saveResult(String result) async {
    await DbHelper.addBarcode({
      'scanTime': DateTime.now().toIso8601String(),
      'content': result
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Barcode Saved!")));
  }
}
