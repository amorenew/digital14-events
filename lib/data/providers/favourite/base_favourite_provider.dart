import 'package:digital14_events/data/models/favourite.dart';

abstract class BaseFavouriteProvider {
  Future<bool> addFavourite(Favourite favourite);

  Future<bool> deleteExpense(Favourite favourite);

  Future<List<Favourite>> getFavourites();
}
