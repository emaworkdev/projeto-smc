import 'package:date_format/date_format.dart';

class FuncaoData {
  int get hojeTimeStamp {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    return timestamp;
  }

  String getHora(String data) {
    var dt = DateTime.parse(data);
    return formatDate(dt, [HH, ':', mm]);
  }

  String getData(String data) {
    var dt = DateTime.parse(data);
    return formatDate(dt, [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
  }

  String formataDataDDMMAAAA(data) {
    if (data == null) {
      return "";
    }

    var datef = data.toString().split("-");
    return "${datef[2]}/${datef[1]}/${datef[0]}";
  }

  DateTime getSomaDia(DateTime data, int qtde) {
    var prevAno =
        DateTime(data.year, DateTime.now().month, DateTime.now().day + qtde);
    return prevAno;
  }
}
