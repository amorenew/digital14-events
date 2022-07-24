import 'package:dartz/dartz.dart';
import 'package:digital14_events/data/models/favourite.dart';
import 'package:digital14_events/data/providers/favourite/base_favourite_provider.dart';
import 'package:digital14_events/domain/respositories/favourite/base_favourite_repository.dart';

class FavouriteRepository extends BaseFavouriteRepository {
  FavouriteRepository(this._provider);

  final BaseFavouriteProvider _provider;

  @override
  Future<Either<FavouriteError, bool>> addFavourite(Favourite favourite) async {
    try {
      final value = await _provider.addFavourite(favourite);

      return Right(value);
    } catch (e) {
      return Left(FavouriteError(e));
    }
  }

  @override
  Future<Either<FavouriteError, bool>> deleteExpense(
    Favourite favourite,
  ) async {
    try {
      final value = await _provider.deleteExpense(favourite);

      return Right(value);
    } catch (e) {
      return Left(FavouriteError(e));
    }
  }

  @override
  Future<Either<FavouriteError, List<Favourite>>> getFavourites() async {
    try {
      final value = await _provider.getFavourites();

      return Right(value);
    } catch (e) {
      return Left(FavouriteError(e));
    }
  }
}
