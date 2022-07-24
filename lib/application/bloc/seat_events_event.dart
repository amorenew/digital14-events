part of 'seat_events_bloc.dart';

@immutable
abstract class SeatEventsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListSeatEvents extends SeatEventsEvent {
  ListSeatEvents({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

class ListFavouriteEvents extends SeatEventsEvent {
  ListFavouriteEvents();

  @override
  List<Object> get props => [];
}

class AddFavouriteSeatEvents extends SeatEventsEvent {
  AddFavouriteSeatEvents(
    this.favourite,
  );

  final Favourite favourite;

  @override
  List<Object> get props => [favourite];
}

class DeleteFavouriteSeatEvents extends SeatEventsEvent {
  DeleteFavouriteSeatEvents(
    this.favourite,
  );

  final Favourite favourite;

  @override
  List<Object> get props => [favourite];
}
