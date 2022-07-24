import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:digital14_events/data/models/event.dart';

abstract class BaseSeatEventRepository {
  Future<Either<SeatEventError, List<Event>>> getEvents({
    required String query,
  });

  Future<Either<SeatEventError, Event?>> getEvent({
    required Map<String, String>? body,
    required String eventId,
  });
}

class SeatEventError extends Error {
  SeatEventError(this.error);

  final dynamic error;
}
