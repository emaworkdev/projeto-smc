import 'package:date_format/date_format.dart';

class FuncaoData {
  int get hojeTimeStamp {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    return timestamp;
  }

  DateTime get hoje {
    return DateTime.now();
  }

  String get hojeYYYYMMDDHHMMSS {
    return formatDate(
        DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
  }

  String get hojeYYYYMMDD {
    return formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
  }

  String dataYYYYMMDD(data) {
    var datef = data.toString().split("-");
    var dd = datef[2].substring(0, 2);

    return "${datef[0]}-${datef[1]}-$dd";
  }

  bool dataMaior(String data1, String data2) {
    var d1 = DateTime.parse(data1);
    var d2 = DateTime.parse(data2);
    if (d2.compareTo(d1) > 0) {
      return true;
    } else {
      return false;
    }
  }

  DateTime getSomaDia(DateTime data, int qtde) {
    var prevAno =
        DateTime(data.year, DateTime.now().month, DateTime.now().day + qtde);
    return prevAno;
  }

  DateTime getDiminuiDia(DateTime data, int qtde) {
    var prevAno =
        DateTime(data.year, DateTime.now().month, DateTime.now().day - qtde);
    return prevAno;
  }

  DateTime getSomaMes(DateTime data, int qtde) {
    var prevAno =
        DateTime(data.year, DateTime.now().month + qtde, DateTime.now().day);
    return prevAno;
  }

  String getSomaMesString(int qtde) {
    var prevAno = DateTime(
        DateTime.now().year, DateTime.now().month + qtde, DateTime.now().day);
    return formataDataAAAAMMDD(prevAno);
  }

  DateTime getDiminuiMes(DateTime data, int qtde) {
    var prevAno = DateTime(
        data.year + qtde, DateTime.now().month - qtde, DateTime.now().day);
    return prevAno;
  }

  String getDiminuiMesString(DateTime data, int qtde) {
    var prevAno =
        DateTime(data.year, DateTime.now().month - qtde, DateTime.now().day);
    return formataDataAAAAMMDD(prevAno);
  }

  DateTime getSomaAno(DateTime data, int qtde) {
    var prevAno =
        DateTime(data.year + qtde, DateTime.now().month, DateTime.now().day);
    return prevAno;
  }

  DateTime getDiminuiAno(DateTime data, int qtde) {
    var prevAno =
        DateTime(data.year - qtde, DateTime.now().month, DateTime.now().day);
    return prevAno;
  }

  String getDiminuiAnoString(DateTime data, int qtde) {
    var prevAno =
        DateTime(data.year - qtde, DateTime.now().month, DateTime.now().day);
    return formataDataAAAAMMDD(prevAno);
  }

  String formataDataAAAAMMDD(data) {
    if (data == null) {
      return "";
    }

    var datef = data.toString().split("-");
    var datedd = datef[2].toString().split(" ");

    return "${datef[0]}-${datef[1]}-${datedd[0]}";
  }
}
