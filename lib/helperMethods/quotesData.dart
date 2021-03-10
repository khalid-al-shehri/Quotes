
import 'package:flutter/cupertino.dart';
import 'package:quotes/model/quoteModel.dart';

class QuotesData extends ChangeNotifier{

  List<QuoteModel> quote = List<QuoteModel>();
  List<QuoteModel> favorite = List<QuoteModel>();

  void updateQuote({List<QuoteModel> listQuote, QuoteModel newQuote}){

    if(listQuote != null){
      List.generate(listQuote.length, (index) {
        quote.add(listQuote[index]);
      });
    }

    if(newQuote != null){
      quote.add(newQuote);
    }

    notifyListeners();
  }

  void updateFavorite({List<QuoteModel> listFavorite, QuoteModel newFavorite}){

    favorite = List<QuoteModel>();

    if(listFavorite != null){
      List.generate(listFavorite.length, (index) {
        favorite.add(listFavorite[index]);
      });
    }

    if(newFavorite != null){
      favorite.add(newFavorite);
    }

    notifyListeners();
  }


}