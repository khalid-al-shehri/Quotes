import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quotes/helperMethods/DBHelper.dart';
import 'package:quotes/helperMethods/quotesData.dart';
import 'package:quotes/model/quoteModel.dart';

class FavoriteHelper{

  final DBHelper dbHelper = DBHelper();

  Future<bool> addedToFavorite({String id}) async {
    List favoriteSavedAsList = await dbHelper.getAllListFavorite();
    bool addedBefore = false;

    List<QuoteModel> favoriteSaved = List.generate(favoriteSavedAsList.length, (index) {
      QuoteModel quoteModel = QuoteModel();
      quoteModel.id = favoriteSavedAsList[index]['IdFetched'];
      quoteModel.author = favoriteSavedAsList[index]['Author'];
      quoteModel.quote = favoriteSavedAsList[index]['Quote'];

      return quoteModel;
    });

    List.generate(favoriteSaved.length, (index) {
      if(favoriteSaved[index].id == id){
        addedBefore = true;
      }
    });

    return addedBefore;

  }

  addToFavorite({String idFetched, String author, String quote}) async {
    await dbHelper.insertFavorite(
        idFetched: idFetched,
        author: author,
        quote: quote
    );
  }

  deleteFromFavorite({String idFetched, BuildContext context}) async {

    await dbHelper.deleteFavorite(
        idFetched: idFetched
    );

    // Read Local database to check if there are old Favorite
    List favoriteSaved = await dbHelper.getAllListFavorite();

    // Get all old Favorite
    List<QuoteModel> oldFavorite = List.generate(favoriteSaved.length, (index) {
      QuoteModel quoteModel = QuoteModel();
      quoteModel.id = favoriteSaved[index]['IdFetched'];
      quoteModel.author = favoriteSaved[index]['Author'];
      quoteModel.quote = favoriteSaved[index]['Quote'];

      return quoteModel;
    });

    // Save them in Favorite provider to show them to user
    Provider.of<QuotesData>(context, listen: false).updateFavorite(
        listFavorite: oldFavorite
    );
  }

}