import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital14_events/application/bloc/seat_events_bloc.dart';
import 'package:digital14_events/data/models/event.dart';
import 'package:digital14_events/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:digital14_events/data/models/favourite.dart';

class EventView extends StatefulWidget {
  final bool isFav;
  final Event? event;
  const EventView({
    Key? key,
    required this.isFav,
    required this.event,
  }) : super(key: key);

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  List<Widget> _imageSliders = <Widget>[];
  Event? _event;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
    _initSlides();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_event!.title!),
        trailing: CupertinoButton(
          child: _event!.favourite
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
              photo: _event?.performers![0].image,
              location: _event?.venue?.displayLocation ?? '',
              eventTime: _event?.datetimeUtc ?? '',
              eventId: _event!.id!.toString(),
              title: _event!.title,
            );
            if (!_event!.favourite) {
              context
                  .read<SeatEventsBloc>()
                  .add(AddFavouriteSeatEvents(favourite));
            } else {
              context
                  .read<SeatEventsBloc>()
                  .add(DeleteFavouriteSeatEvents(favourite));
            }

            setState(() {
              _event!.favourite = !_event!.favourite;
            });
          },
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight * 1.5),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 2.0,
                enlargeCenterPage: false,
              ),
              items: _imageSliders,
            ),
          ),
          if (_event?.datetimeUtc != null)
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 3),
              child: Text(
                parseDate(_event!.datetimeUtc!),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: CupertinoColors.black),
              ),
            ),
          if (_event?.venue?.displayLocation != null)
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 3),
              child: Text(
                _event!.venue!.displayLocation!,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black54),
              ),
            )
        ],
      ),
    );
  }

  _initSlides() {
    _imageSliders = _event!.performers!
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item.image,
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            item.name!,
                            style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      item.primary
                          ? const Positioned(
                              bottom: 5.0,
                              right: 5.0,
                              child: Icon(
                                MaterialCommunityIcons.star,
                                color: CupertinoColors.systemYellow,
                              ))
                          : Container()
                    ],
                  )),
            ))
        .toList();
  }
}
