import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../data/model/house_rules_model.dart';
import 'package:http/http.dart' as http;

class HouseRulesService extends ChangeNotifier {
  String url = 'https://sys-dev.searchandstay.com/api/admin/house_rules';
  String token =
      '40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8';

  final List<HouseRulesModel> _houseRulesModel = [];
  int _page = 1;
  List<HouseRulesModel> get houseRulesModel => _houseRulesModel;

  getEntities() async {
    try{
      var response = await http.get(
          Uri.parse(
              'https://sys-dev.searchandstay.com/api/admin/house_rules?page=$_page'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            HttpHeaders.authorizationHeader: 'Bearer $token',
          });
      final responseJson = jsonDecode(response.body)['data']['entities'];
      for (var i = 0; i < responseJson.length; i++) {
        _houseRulesModel.add(HouseRulesModel.fromJson(responseJson[i]));
      }
      _page++;
      notifyListeners();
    }on SocketException catch (e) {
      throw 'Error: No Internet';
    } on HttpException {
      throw 'Error: No Service Found';
    } on FormatException {
      throw 'Error: Invalid Data Format';
    } catch (e) {
      throw 'Error: Unknown error';
    }
  }

  Future<HouseRulesModel> getEntity(int id) async {
    try {
      var response = await http.get(Uri.parse('$url/$id'), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      final responseJson = jsonDecode(response.body);
      return HouseRulesModel.fromJson(responseJson['data']);
    }on SocketException catch (e) {
      throw 'Error: No Internet';
    } on HttpException {
      throw 'Error: No Service Found';
    } on FormatException {
      throw 'Error: Invalid Data Format';
    } catch (e) {
      throw 'Error: Unknown error';
    }
  }

  Future<bool> insertEntity(HouseRulesModel searchListModel) async {
    try {
      Map body = {
        "house_rules": {
          "name": searchListModel.name,
          "active": searchListModel.active,
          "order": searchListModel.order
        }
      };
      var response =
      await http.post(Uri.parse(url), body: json.encode(body), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      final responseJson = jsonDecode(response.body);
      return responseJson['success'];
    }on SocketException catch (e) {
      throw 'Error: No Internet';
    } on HttpException {
      throw 'Error: No Service Found';
    } on FormatException {
      throw 'Error: Invalid Data Format';
    } catch (e) {
      throw 'Error: Unknown error';
    }
  }

  Future<bool> updateEntity(int id, HouseRulesModel houseRulesModel) async {
    try {
      Map body = {
        "house_rules": {
          "name": houseRulesModel.name,
          "active": houseRulesModel.active,
          "order": houseRulesModel.order
        }
      };
      var response = await http
          .put(Uri.parse('$url/$id'), body: json.encode(body), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      final responseJson = jsonDecode(response.body);
      return responseJson['success'];
    }on SocketException catch (e) {
      throw 'Error: No Internet';
    } on HttpException {
      throw 'Error: No Service Found';
    } on FormatException {
      throw 'Error: Invalid Data Format';
    } catch (e) {
      throw 'Error: Unknown error';
    }
  }

  Future<bool> deleteEntity(int id) async {
    try {
      var response = await http.delete(Uri.parse('$url/$id'), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      final responseJson = jsonDecode(response.body);
      return responseJson['success'];
    }on SocketException catch (e) {
      throw 'Error: No Internet';
    } on HttpException {
      throw 'Error: No Service Found';
    } on FormatException {
      throw 'Error: Invalid Data Format';
    } catch (e) {
      throw 'Error: Unknown error';
    }
  }
}
