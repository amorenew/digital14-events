import 'package:digital14_events/app/data/models/event.dart';
import 'package:digital14_events/app/data/models/favourite.dart';
import 'package:digital14_events/app/domain/respositories/favourite/favourite_repository.dart';
import 'package:digital14_events/app/domain/respositories/seat_event/seat_event_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'seat_events_event.dart';
part 'seat_events_state.dart';

class SeatEventsBloc extends Bloc<SeatEventsEvent, SeatEventsState> {
  final SeatEventRepository _seatEventRepository;
  final FavouriteRepository _favouriteRepository;

  SeatEventsBloc(this._seatEventRepository, this._favouriteRepository)
      : super(SeatEventsState(
          isLoading: false,
        )) {
    on<ListSeatEvents>(
      (event, emit) async {
        await _onListSeatEvents(event, emit);
      },
    );

    on<ListFavouriteEvents>(
      (event, emit) async {
        await _onListFavouriteEvents(event, emit);
      },
    );

    on<AddFavouriteSeatEvents>(
      (event, emit) async {
        await _onAddFavouriteSeatEvents(event, emit);
      },
    );

    on<DeleteFavouriteSeatEvents>(
      (event, emit) async {
        await _onDeleteFavouriteSeatEvents(event, emit);
      },
    );
  }

  Future<void> _onListSeatEvents(
    ListSeatEvents event,
    Emitter<SeatEventsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final eventResponse = await _seatEventRepository.getEvents(
      query: event.query,
    );

    eventResponse.fold(
      (error) {
        Logger().e(
          "error: $error, ${error.error} |  | ${(error.error is Error) ? (error.error as Error).stackTrace : ''}",
        );
        emit(
          state.copyWith(
            error: error.error.toString(),
          ),
        );
      },
      (events) {
        emit(
          state.copyWith(
            success: true,
            events: events,
          ),
        );

        add(ListFavouriteEvents());
      },
    );
  }

  Future<void> _onAddFavouriteSeatEvents(
    AddFavouriteSeatEvents event,
    Emitter<SeatEventsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    await _favouriteRepository.addFavourite(
      event.favourite,
    );

    add(ListFavouriteEvents());
  }

  Future<void> _onDeleteFavouriteSeatEvents(
    DeleteFavouriteSeatEvents event,
    Emitter<SeatEventsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    await _favouriteRepository.deleteExpense(
      event.favourite,
    );

    add(ListFavouriteEvents());
  }

  Future<void> _onListFavouriteEvents(
    ListFavouriteEvents event,
    Emitter<SeatEventsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final eventResponse = await _favouriteRepository.getFavourites();

    eventResponse.fold(
      (error) {
        Logger().e(
          "error: $error, ${error.error} |  | ${(error.error is Error) ? (error.error as Error).stackTrace : ''}",
        );
        emit(
          state.copyWith(
            error: error.error.toString(),
          ),
        );
      },
      (favourites) {
        final favoutiteIds = favourites.map((e) => int.tryParse(e.eventId!));
        final events = state.events.map((event) {
          event.favourite = favoutiteIds.contains(event.id);
          return event;
        }).toList();

        emit(
          state.copyWith(
            success: true,
            events: events,
            favourites: favourites,
          ),
        );
      },
    );
  }
}
