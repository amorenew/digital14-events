import 'package:digital14_events/app/data/models/event.dart';
import 'package:dartz/dartz.dart';
import 'package:digital14_events/app/data/providers/seat_event/base_seat_event_provider.dart';
import 'package:digital14_events/app/domain/respositories/seat_event/base_seat_event_repository.dart';

class SeatEventRepository extends BaseSeatEventRepository {
  SeatEventRepository(this._provider);

  final BaseSeatEventProvider _provider;

  @override
  Future<Either<SeatEventError, List<Event>>> getEvents({
    required String query,
  }) async {
    try {
      final value = await _provider.getEvents(
        query: query,
      );

      return Right(value!.events!);
    } catch (e) {
      return Left(SeatEventError(e));
    }
  }

  @override
  Future<Either<SeatEventError, Event?>> getEvent({
    required Map<String, String>? body,
    required String eventId,
  }) async {
    try {
      final value = await _provider.getEvent(
        body: body,
        eventId: eventId,
      );

      return Right(value);
    } catch (e) {
      return Left(SeatEventError(e));
    }
  }
}
