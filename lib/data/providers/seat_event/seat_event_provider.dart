import 'dart:convert';

import 'package:digital14_events/data/models/event.dart';
import 'package:digital14_events/data/models/events_response.dart';
import 'package:digital14_events/data/providers/seat_event/base_seat_event_provider.dart';
import 'package:digital14_events/constant/urls.dart';
import 'package:digital14_events/utils/api_controller.dart';

class SeatEventProvider extends BaseSeatEventProvider {
  @override
  Future<EventsResponse?> getEvents({
    required String query,
  }) async {
    Map<String, String>? body = <String, String>{};
    if (query.isNotEmpty) {
      body.putIfAbsent('q', () => query);
    } else {
      body = null;
    }

    var response = await apiCall(url: urlListEvents, body: body);
    if (response!.statusCode == 200) {
      var data = json.decode(response.body);
      return EventsResponse.fromJson(data);
    } else {
      return EventsResponse(error: true, events: [], meta: null);
    }
  }

  @override
  Future<Event?> getEvent({
    required Map<String, String>? body,
    required String eventId,
  }) async {
    var response = await apiCall(url: urlListEvents + eventId, body: body);
    if (response!.statusCode == 200) {
      var data = json.decode(response.body);
      return Event.fromJson(data);
    } else {
      return Event(favourite: false);
    }
  }
}
