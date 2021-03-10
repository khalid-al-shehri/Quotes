import 'package:quotes/helperMethods/DBHelper.dart';
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

}