import 'package:flutterapitut/model/challge_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String serverUrl = "http://flutterapitutorial.codeforiraq.org/api";
  String serverUrl2 =
      "https://shielded-spire-40270.herokuapp.com/auth/jwt/create/";
  String serverUrl3 =
      "https://shielded-spire-40270.herokuapp.com/api/app-challenges/challenge";
  var status;

  var access;

  loginData(String username, String password) async {
    String myUrl = "$serverUrl2";
    final response = await http.post(myUrl,
        headers: {'Accept': 'application/json'},
        body: {"username": "$username", "password": "$password"});
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["access"]}');
      _save(data["access"]);
    }
  }

  registerData(String name, String email, String password) async {
    String myUrl = "$serverUrl/register1";
    final response = await http.post(myUrl,
        headers: {'Accept': 'application/json'},
        body: {"name": "$name", "email": "$email", "password": "$password"});
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  Future<List<Movie>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl3";
    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    var data = json.decode(response.body);
    List result = data['results'];
    print(result);

    return result.map((e) => Movie.fromJson(e)).toList();
    // return json.decode(response.body);
  }

  void deleteData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/products/$id";
    http.delete(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void addData(String name, String price) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/products";
    http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$name",
      "price": "$price"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void editData(int id, String name, String price) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://flutterapitutorial.codeforiraq.org/api/products/$id";
    http.put(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$name",
      "price": "$price"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  _save(String access) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access';
    final value = access;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
