import 'package:digital14_events/app/data/providers/favourite/favourite_provider.dart';
import 'package:digital14_events/app/data/providers/seat_event/seat_event_provider.dart';
import 'package:digital14_events/app/domain/respositories/favourite/favourite_repository.dart';
import 'package:digital14_events/app/domain/respositories/seat_event/seat_event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/presentation/ui/app.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SeatEventRepository>(
          create: (context) => SeatEventRepository(
            SeatEventProvider(),
          ),
        ),
        RepositoryProvider<FavouriteRepository>(
          create: (context) => FavouriteRepository(
            FavouriteProvider(),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
