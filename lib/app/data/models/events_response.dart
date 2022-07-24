import 'package:digital14_events/app/data/models/event.dart';
import 'package:flutter/foundation.dart';

class EventsResponse {
  List<Event>? events;
  Meta? meta;
  bool? error;

  EventsResponse({this.events, this.meta, this.error});

  EventsResponse.fromJson(Map<String, dynamic> json) {
    try {
      if (json['events'] != null) {
        events = <Event>[];
        json['events'].forEach((v) {
          events!.add(Event.fromJson(v));
        });
      }
      meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}
