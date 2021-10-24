import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:first_ally_demo/app/core/utils/custom_exception.dart';

class ApiProvider {
  final String _paystackBaseUrl = "https://api.paystack.co/bank";

  Future<dynamic> getListOfBanks() async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_paystackBaseUrl+"?country=nigeria&use_cursor=false"),
          headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer sk_test_4591a11b450e04e4d94d482ea30d9deceae710d3"},
      );

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> resolveAccountNumber(String accountNumber, String bankCode) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_paystackBaseUrl+"/resolve?account_number=$accountNumber&bank_code=$bankCode"),
          headers: {HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer sk_test_4591a11b450e04e4d94d482ea30d9deceae710d3"},
      );

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 422:
      case 401:
      case 404:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 403:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:

      default:
        print('Error occured while Communication with Server with StatusCode : ${response.statusCode}, message: ${response.body}');
        var errorList = response.body.split('"error":');
        throw FetchDataException(
            errorList[1]);
    }
  }
}