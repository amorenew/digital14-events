import 'package:digital14_events/app/application/bloc/seat_events_bloc.dart';
import 'package:digital14_events/app/data/models/event.dart';
import 'package:digital14_events/app/presentation/theme/styles.dart';
import 'package:digital14_events/app/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:digital14_events/app/data/models/favourite.dart';

import 'event_view.dart';

class EvenItemView extends StatefulWidget {
  final Event event;
  final bool lastItem;

  const EvenItemView({
    Key? key,
    required this.event,
    required this.lastItem,
  }) : super(key: key);

  @override
  State<EvenItemView> createState() => _EvenItemViewState();
}

class _EvenItemViewState extends State<EvenItemView> {
  @override
  Widget build(BuildContext context) {
    final item = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(
            builder: (context) => EventView(
              event: widget.event,
              isFav: false,
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
                      widget.event.performers![0].image,
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
                        widget.event.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          widget.event.venue!.displayLocation!,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        ),
                      ),
                      Text(
                        parseDate(widget.event.datetimeUtc!),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: CupertinoButton(
                  child: widget.event.favourite
                      ? const Icon(
                          MaterialCommunityIcons.heart,
                          color: CupertinoColors.systemRed,
                        )
                      : const Icon(
                          MaterialCommunityIcons.heart_outline,
                          color: CupertinoColors.systemRed,
                        ),
                  onPressed: () async {
                    Favourite favourite = Favourite(
                        photo: widget.event.performers![0].image,
                        location: widget.event.venue!.displayLocation!,
                        eventTime: widget.event.datetimeUtc!,
                        eventId: widget.event.id!.toString(),
                        title: widget.event.title);
                    if (!widget.event.favourite) {
                      context
                          .read<SeatEventsBloc>()
                          .add(AddFavouriteSeatEvents(favourite));
                    } else {
                      context
                          .read<SeatEventsBloc>()
                          .add(DeleteFavouriteSeatEvents(favourite));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
    if (widget.lastItem) {
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
