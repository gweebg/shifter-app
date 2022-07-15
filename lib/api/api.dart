import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ManagerAPI {
  String url;

  ManagerAPI(this.url); /* http://127.0.0.1:8000 */

  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};

  getCourses() async {
    String fullUrl = '$url/courses';
    http.Response response =
        await http.get(Uri.parse(fullUrl), headers: _setHeaders());

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Could not send get request to $url.');
    }
  }

  testCall() async {
    String newURL =
        "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Portugal%2C%20Viana%20do%20Castelo?unitGroup=metric&key=YOUR_API_KEY&contentType=json";

    http.Response response =
        await http.get(Uri.parse(newURL), headers: _setHeaders());
  }

  getJson(String courseName, int year, String weekDate, [shifts]) async {
    String fullUrl = "$url/generate/json/";

    var data = {
      "course_name": courseName,
      "year": year,
      "week_date": weekDate,
    };

    if (shifts != null) data["shifts"] = shifts;

    http.Response response = await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Could not send post request to $url (context: json).');
    }
  }

  getExcel(String courseName, int year, String weekDate, shifts) async {
    String fullUrl = "$url/generate/excel/";

    var data = {
      "course_name": courseName,
      "year": year,
      "week_date": weekDate,
      "shifts": shifts
    };

    http.Response response = await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());

    if (response.statusCode == 200) {
      print(response.headers);
      // print(utf8.decode(response.bodyBytes));
      // return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Could not send post request to $url (context: excel).');
    }
  }
}

void main() {
  ManagerAPI caller = ManagerAPI("http://127.0.0.1:8000");
  // caller.getCourses();

  var shifts = {
    "Investigação Operacional": ["T1", "TP4"],
    "Bases de Dados": ["T2", "PL4"],
    "Métodos Numéricos e Otimização não Linear": ["T1", "PL3"],
    "Programação Orientada aos Objetos": ["T1", "PL3"],
    "Redes de Computadores": ["T1", "PL9"],
    "Sistemas Operativos": ["T2", "PL9"]
  };

  // caller.getJson("Licenciatura em Engenharia Informática", 2, "12-05-2022", shifts);
  // caller.getJson("Licenciatura em Engenharia Informática", 2, "12-05-2022");
  caller.getExcel(
      "Licenciatura em Engenharia Informática", 2, "12-05-2022", shifts);
}
