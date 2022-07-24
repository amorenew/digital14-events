import 'package:digital14_events/application/bloc/seat_events_bloc.dart';
import 'package:digital14_events/presentation/theme/styles.dart';
import 'package:digital14_events/presentation/ui/widgets/favourite_item.dart';
import 'package:digital14_events/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({Key? key}) : super(key: key);

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SeatEventsBloc>().add(
          ListFavouriteEvents(),
        );

    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Styles.scaffoldBackground,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<SeatEventsBloc, SeatEventsState>(
                  builder: (context, state) {
                    if (state.favourites.isEmpty) {
                      return svgImage(100, 100, "No favourites found!",
                          'images/empty_favourites.svg');
                    }

                    return ListView.builder(
                      itemBuilder: (context, index) => FavouriteItem(
                        favourite: state.favourites[index],
                        lastItem: index == state.favourites.length - 1,
                      ),
                      itemCount: state.favourites.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
