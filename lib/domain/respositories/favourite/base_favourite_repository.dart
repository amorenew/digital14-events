import 'package:dartz/dartz.dart';
import 'package:digital14_events/data/models/favourite.dart';

abstract class BaseFavouriteRepository {
  Future<Either<FavouriteError, bool>> addFavourite(Favourite favourite);

  Future<Either<FavouriteError, bool>> deleteExpense(Favourite favourite);

  Future<Either<FavouriteError, List<Favourite>>> getFavourites();
}

class FavouriteError extends Error {
  FavouriteError(this.error);

  final dynamic error;
}
