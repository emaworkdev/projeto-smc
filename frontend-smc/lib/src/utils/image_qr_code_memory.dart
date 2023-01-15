import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

// ignore: must_be_immutable
class ImageQrCodeMemory extends StatelessWidget {
  String image;
  ImageQrCodeMemory({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var img = image.substring(22, image.length);
    return getImagenBase64(image);
  }

  getImagenBase64(String imagen) {
    var imageBase64 = imagen;
    const Base64Codec base64 = Base64Codec();
    if (imageBase64.isEmpty) return Container();
    Uint8List bytes = base64.decode(imageBase64);
    return Image.memory(
      bytes,
      width: 228,
      height: 228,
      fit: BoxFit.fitWidth,
    );
  }
}
