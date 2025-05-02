import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart';

Future<Image?> genrateLogo()async{
final ByteData data = await rootBundle.load('assets/image/logo.png');
final Uint8List bytes = data.buffer.asUint8List();
final Image? image = decodeImage(bytes);
return image;
}