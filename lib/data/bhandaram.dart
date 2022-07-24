/* import 'package:digital14_events/app/data/models/favourite.dart';

class Bhandaram {
  static DbHelper? db;
  static List<Favourite> favourites = <Favourite>[];

  static init() {
    db = DbHelper();
    _loadFavourites();
  }

  static _loadFavourites() async {
    favourites.clear();
    var storedFavourites = await db!.getFavourites();
    favourites.addAll(storedFavourites);
  }

  static updateFavourites() {
    _loadFavourites();
  }

  static unFavItem(String id) {
    List<Favourite> items = [];
    for (int i = 0; i < favourites.length; i++) {
      if (favourites[i].eventId != id) {
        items.add(favourites[i]);
      }
    }
    favourites.clear();
    favourites.addAll(items);
  }
}
 */