import 'package:digital14_events/application/bloc/seat_events_bloc.dart';
import 'package:digital14_events/data/models/event.dart';
import 'package:digital14_events/presentation/theme/styles.dart';
import 'package:digital14_events/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:digital14_events/data/models/favourite.dart';

import 'event_view.dart';

class FavouriteItem extends StatelessWidget {
  final Favourite favourite;
  final bool lastItem;

  const FavouriteItem({
    Key? key,
    required this.favourite,
    required this.lastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Event event = Event(
            favourite: true,
            title: favourite.title,
            id: int.parse(favourite.eventId!),
            performers: [
              Performers(
                name: favourite.title,
                image: favourite.photo ?? '',
                primary: false,
              )
            ]);
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(
            builder: (context) => EventView(
              event: event,
              isFav: true,
            ),
          ),
        );
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      favourite.photo!,
                      fit: BoxFit.cover,
                      height: 80,
                      width: 120,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        favourite.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if ((favourite.location ?? '').isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            favourite.location!,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      if ((favourite.eventTime ?? '').isNotEmpty)
                        Text(
                          parseDate(favourite.eventTime!),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Center(
                child: CupertinoButton(
                  child: const Icon(
                    MaterialCommunityIcons.heart,
                    color: CupertinoColors.systemRed,
                  ),
                  onPressed: () async {
                    context
                        .read<SeatEventsBloc>()
                        .add(DeleteFavouriteSeatEvents(favourite));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
    if (lastItem) {
      return item;
    }

    return Column(
      children: <Widget>[
        item,
        Padding(
          padding: const EdgeInsets.only(
            left: 160,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.eventRowDivider,
          ),
        ),
      ],
    );
  }
}
