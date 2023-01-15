import 'package:encrypt/encrypt.dart';

class EncryptDecrypt {
  final key = Key.fromUtf8('put32charactershereeeeeeeeeeeee!'); //32 chars
  final iv = IV.fromUtf8('put16characters!'); //16 chars

  //encrypt
  String encryptData(String text) {
    final e = Encrypter(AES(key, mode: AESMode.cbc));
    final encryptedData = e.encrypt(text, iv: iv);
    return encryptedData.base64;
  }

//dycrypt
  String decryptData(String text) {
    final e = Encrypter(AES(key, mode: AESMode.cbc));
    final decryptedData = e.decrypt(Encrypted.fromBase64(text), iv: iv);
    return decryptedData;
  }
}
