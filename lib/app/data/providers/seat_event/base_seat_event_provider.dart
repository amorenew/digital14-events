import 'package:digital14_events/app/data/models/event.dart';
import 'package:digital14_events/app/data/models/events_response.dart';

abstract class BaseSeatEventProvider {
  Future<EventsResponse?> getEvents({
    required String query,
  });

  Future<Event?> getEvent({
    required Map<String, String>? body,
    required String eventId,
  });
}
