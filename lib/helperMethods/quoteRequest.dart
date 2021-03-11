import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quotes/helperMethods/quotesData.dart';
import 'package:quotes/helperMethods/DBHelper.dart';
import 'package:quotes/model/quoteModel.dart';
import 'UIcontroller.dart';
import 'fetchAPI.dart';

class QuoteRequest{

  final APIRequestsHelper apiRequestsHelper = APIRequestsHelper();
  final DBHelper dbHelper = DBHelper();

  // numberOfRetry is variable to search limited times to find new quote.
  getNewQuote({BuildContext context, int numberOfRetry = 15, Function startLoading, Function stopLoading}) async {

    Map<String,String> header = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    // The response of (api.quotable.io) will saved as QuoteModel
    QuoteModel responseNewQuote = await apiRequestsHelper.get(
      url: "https://api.quotable.io/random?tags=inspirational",
      header: header,
      printResults: false,
      startLoading: startLoading,
      stopLoading: stopLoading,
    );

    if(responseNewQuote != null){

      bool savedBefore = await dbHelper.searchForFetchedIDQuotes(responseNewQuote.id);

      if(savedBefore == false){

        Provider.of<QuotesData>(context, listen: false).updateQuote(
            newQuote: responseNewQuote
        );

        await dbHelper.insertQuotes(
            idFetched: responseNewQuote.id,
            author: responseNewQuote.author,
            quote: responseNewQuote.quote
        );

      }
      else{
        getNewQuote(
          context: context,
          numberOfRetry: numberOfRetry - 1,
          startLoading: startLoading(),
          stopLoading: stopLoading()
        );
      }

    }


  }

}