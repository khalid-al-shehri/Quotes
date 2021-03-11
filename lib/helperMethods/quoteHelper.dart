import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quotes/helperMethods/DBHelper.dart';
import 'package:quotes/helperMethods/quotesData.dart';
import 'package:quotes/model/quoteModel.dart';

class QuoteHelper{

  final DBHelper dbHelper = DBHelper();

  deleteFromQuotes({String idFetched, BuildContext context}) async {

    await dbHelper.deleteQuotes(
        idFetched: idFetched
    );

    // Read Local database to check if there are old Favorite
    List quotesSaved = await dbHelper.getAllListQuotes();

    // Get all old Favorite
    List<QuoteModel> allQuotes = List.generate(quotesSaved.length, (index) {
      QuoteModel quoteModel = QuoteModel();
      quoteModel.id = quotesSaved[index]['IdFetched'];
      quoteModel.author = quotesSaved[index]['Author'];
      quoteModel.quote = quotesSaved[index]['Quote'];

      return quoteModel;
    });

    // Save them in Favorite provider to show them to user
    Provider.of<QuotesData>(context, listen: false).refreshQuote(
        listQuote: allQuotes
    );

  }

}