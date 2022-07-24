import 'package:digital14_events/app/application/bloc/seat_events_bloc.dart';
import 'package:digital14_events/app/presentation/theme/styles.dart';
import 'package:digital14_events/app/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/event_item.dart';
import '../widgets/search_bar.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocus;
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_onTextChanged);
    _searchFocus = FocusNode();
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_terms != _searchController.text) {
      _terms = _searchController.text;
      if (_terms.isNotEmpty && _terms.length > 2) {
        context.read<SeatEventsBloc>().add(
              ListSeatEvents(query: _terms),
            );
      }
    }
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xFF233447),
      child: SearchBar(
        controller: _searchController,
        focusNode: _searchFocus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<SeatEventsBloc>().add(
          ListSeatEvents(query: ''),
        );

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: BlocBuilder<SeatEventsBloc, SeatEventsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return _getShimmer();
                  }

                  if (state.events.isEmpty) {
                    return svgImage(
                      100,
                      100,
                      "No events found!",
                      'images/empty_events.svg',
                    );
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) => EvenItemView(
                      event: state.events[index],
                      lastItem: index == state.events.length - 1,
                    ),
                    itemCount: state.events.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /* _loadEvents(BuildContext context, String query) async {
    setState(() {
      _loading = true;
      _events.clear();
    });
    try {
      Map<String, String>? myQuery = <String, String>{};
      if (query != "") {
        myQuery.putIfAbsent("q", () => query);
      } else {
        myQuery = null;
      }
      var data = await getEvents(context: context, body: myQuery);
      for (int i = 0; i < data!.events!.length; i++) {
        if (checkFavourite(data.events![i].id!.toString())) {
          data.events![i].favourite = true;
        }
      }
      _events = data.events!;
      _loading = false;
      if (mounted) {
        setState(() {});
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  } */

  Widget _getShimmer() {
    return Shimmer.fromColors(
      baseColor: Styles.shimmerBase,
      highlightColor: Styles.shimmerHighLight,
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(15, (index) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Styles.shimmerBorder))),
                        width: 120,
                        height: 80,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      side: const BorderSide(
                                          color: Styles.shimmerBorder))),
                              width: 300,
                              height: 24.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        side: const BorderSide(
                                            color: Styles.shimmerBorder))),
                                width: 120,
                                height: 20.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        side: const BorderSide(
                                            color: Styles.shimmerBorder))),
                                width: 200,
                                height: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

/*   bool checkFavourite(String id) {
    for (var element in Bhandaram.favourites) {
      if (element.eventId.toString() == id) {
        return true;
      }
    }
    return false;
  } */
}
