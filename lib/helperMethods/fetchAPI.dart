import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:quotes/helperMethods/UIcontroller.dart';
import 'package:quotes/model/quoteModel.dart';

class APIRequestsHelper{

  Future<QuoteModel> get({
    String url,
    Map<String,String> header,
    bool printResults = false
  }) async {

    // Check of internet connection
    try {
      final result = await InternetAddress.lookup('google.com');

      // Internet connected
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Internet connected
        try{

          var resBody = await http.get(
            url,
            headers: header,
          ).timeout(Duration(seconds: 2));

          var response = json.decode(resBody.body);

          // Print results
          if(printResults == true){
            print("URL : ${url}");
            print("statusCode : ${resBody.statusCode.toString()}");
            print("Body : ");
            log(resBody.body);
          }


          // 200
          if(resBody.statusCode == 200){
            QuoteModel quoteModel = QuoteModel();
            quoteModel.id = response['_id'];
            quoteModel.author = response['author'] == null ? "UNKNOWN" : response['author'];
            quoteModel.quote = response['content'];

            return quoteModel;
          }
        }
        // Other Exception
        catch (e) {
          if(printResults == true){
            print(e.toString());
          }
        }
      }
    }
    // Internet not connected
    on SocketException catch (e) {
      if(printResults == true){
        print(e.toString());
      }
    }
  }

}