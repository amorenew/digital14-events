part of 'seat_events_bloc.dart';

class SeatEventsState with EquatableMixin {
  SeatEventsState({
    required this.isLoading,
    this.success = true,
    this.error = '',
    this.events = const [],
    this.favourites = const [],
  });
  final bool isLoading;
  final List<Event> events;
  final List<Favourite> favourites;
  final bool success;
  final String error;

  @override
  List<Object?> get props => [isLoading, success, events, favourites, error];

  SeatEventsState copyWith({
    bool isLoading = false,
    bool success = false,
    List<Event>? events,
    List<Favourite>? favourites,
    String error = '',
  }) =>
      SeatEventsState(
        isLoading: isLoading,
        success: success,
        events: events ?? this.events,
        favourites: favourites ?? this.favourites,
        error: error,
      );
}
