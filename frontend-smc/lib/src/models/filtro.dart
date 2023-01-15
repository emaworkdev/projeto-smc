import 'dart:convert';

class Filtro {
  String? page;
  String? total;
  String? search;
  String? all;
  String? di;
  String? df;

  Filtro({this.search, this.all, this.di, this.df, this.page, this.total});

  Filtro.fromJson(Map<String, dynamic> jsonDados) {
    page = jsonDados['page'];
    total = jsonDados['total'];
    search = jsonDados['search'];
    all = jsonDados['all'];
    di = jsonDados['di'];
    df = jsonDados['df'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};
    jsonDados['page'] = page;
    jsonDados['total'] = total;
    jsonDados['search'] = search;
    jsonDados['all'] = all;
    jsonDados['di'] = di;
    jsonDados['df'] = df;
    return jsonDados;
  }
}

String filtroEncodeJson(Filtro filtro) {
  final jsonDados = filtro.toJson;
  return json.encode(jsonDados);
}
