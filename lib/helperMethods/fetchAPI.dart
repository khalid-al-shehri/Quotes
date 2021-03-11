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
    bool printResults = false,
    Function startLoading,
    Function stopLoading
  }) async {


    // Check of internet connection
    try {
      final result = await InternetAddress.lookup('google.com');

      // Internet connected
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Internet connected
        try{

          startLoading();

          var resBody = await http.get(
            url,
            headers: header,
          ).timeout(Duration(seconds: 20));

          stopLoading();

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
          else{
            showInSnackBar("Somethinfg went worng, please try again.");
          }
        }
        // Other Exception
        catch (e) {
          // stopLoading();
          if(printResults == true){
            print(e.toString());
          }
        }
      }
      else{
        stopLoading();
        showInSnackBar("No Internet, please check your connection.");
      }
    }
    // Internet not connected
    on SocketException catch (e) {
      stopLoading();
      if(printResults == true){
        print(e.toString());
      }
    }
  }

}