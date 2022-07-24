import 'package:digital14_events/app/application/bloc/seat_events_bloc.dart';
import 'package:digital14_events/app/domain/respositories/favourite/favourite_repository.dart';
import 'package:digital14_events/app/domain/respositories/seat_event/seat_event_repository.dart';
import 'package:digital14_events/app/presentation/ui/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SeatEventsBloc(
        RepositoryProvider.of<SeatEventRepository>(context),
        RepositoryProvider.of<FavouriteRepository>(context),
      ),
      child: const CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF233447),
        ),
        home: Home(),
      ),
    );
  }
}
//Color(0xFF233447)