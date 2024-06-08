import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:event_finder_app/features/auth/presentation/widget/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../components/app_bar.dart';

class QrCodePage extends StatefulWidget {
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String fullName;
  final int id;
  final String title;
  final String imageUrl;
  final double prix;
  final String description;
  final String adress;
  final String duree;
  final String date;
  const QrCodePage(
      {super.key,
      required this.cardNumber,
      required this.expiryDate,
      required this.cvv,
      required this.fullName,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.prix,
      required this.description,
      required this.adress,
      required this.duree,
      required this.date});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  final TextEditingController _textController = TextEditingController(text: '');
  String data = '';
  final GlobalKey _qrkey = GlobalKey();
  bool dirExists = false;
  dynamic externalDir;

  @override
  void initState() {
    super.initState();
    _getExternalDir();
  }

  Future<void> _getExternalDir() async {
    data="${widget.fullName}  ${widget.title} ${widget.description} ${widget.date} ${widget.duree}";
    // final directory = await getExternalStorageDirectory();
    // final directory = await  getDownloadsDirectory();
    // Get the external storage directory
    // final directory = await getExternalStorageDirectory();
    final directory1 = await getExternalStorageDirectory();
    // Get the Downloads directory
    // final downloadsDir = Directory('${externalDir?.path}/Download');

    setState(() {
      externalDir = '${directory1!.path}/Qr_code';
      print("saaaaaaaaaaaaaaaaaaaaaaad" + externalDir);
    });
  }

  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);

      //Drawing White Background because Qr Code is Black
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Check for duplicate file name to avoid Override
      String fileName = 'qr_code';
      int i = 1;
      while (await File('$externalDir/$fileName.png').exists()) {
        fileName = 'qr_code_$i';
        i++;
      }

      // Check if Directory Path exists or not
      dirExists = await File(externalDir).exists();
      //if not then create the path
      if (!dirExists) {
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;
      const snackBar = SnackBar(content: Text('QR code saved to gallery'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('Something went wrong!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  buildQrImage() => QrImageView(
        data: data,
        version: QrVersions.auto,
        size: 250.0,
        gapless: true,
        errorStateBuilder: (ctx, err) {
          return const Center(
            child: Text(
              'Something went wrong!!!',
              textAlign: TextAlign.center,
            ),
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('Welcome to our Event'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Center(
                child: RepaintBoundary(
                  key: _qrkey,
                  child: buildQrImage(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RawMaterialButton(
                onPressed: _captureAndSavePng,
                fillColor: kPrimaryColor,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                child: const Text(
                  'Export',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
