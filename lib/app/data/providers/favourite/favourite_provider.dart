import 'dart:convert';

import 'package:digital14_events/app/data/models/favourite.dart';
import 'package:digital14_events/app/data/providers/favourite/base_favourite_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider extends BaseFavouriteProvider {
  @override
  Future<bool> addFavourite(Favourite favourite) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> values = {};
    values.putIfAbsent('title', () => favourite.title!);
    values.putIfAbsent('event_id', () => favourite.eventId!);
    values.putIfAbsent('location', () => favourite.location!);
    values.putIfAbsent('event_time', () => favourite.eventTime!);
    values.putIfAbsent('photo', () => favourite.photo!);
    String item = json.encode(values);

    return prefs.setString('favourite_${favourite.eventId!}', item);
  }

  @override
  Future<bool> deleteExpense(Favourite favourite) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.remove('favourite_${favourite.eventId!}');
  }

  @override
  Future<List<Favourite>> getFavourites() async {
    List<Favourite> favourites = [];
    SharedPreferences.getInstance().then((data) {
      data.getKeys().forEach((key) {
        if (key.startsWith('favourite_')) {
          final value = json.decode(data.getString(key)!);
          favourites.add(Favourite(
              id: value['id'],
              title: value['title'],
              eventId: value['event_id'].toString(),
              eventTime: value['event_time'],
              location: value['location'],
              photo: value['photo']));
        }
      });
    });

    return favourites;
  }
}
