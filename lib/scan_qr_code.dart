import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrResult = 'Scanned Data will appear here';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                qrResult,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    scanQr();
                  },
                  child: const Text('Scan QR Code'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanQr() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      Uri code = Uri.parse(qrCode);
      if (await canLaunchUrl(code)) {
        launchUrl(code);
        setState(() {
          qrResult = 'Launching URL';
        });
      } else {
        setState(() {
          qrResult = qrCode.toString();
        });
      }
    } on PlatformException {
      setState(() {
        qrResult = 'Failed to read Qr Code';
      });
    }
  }
}
