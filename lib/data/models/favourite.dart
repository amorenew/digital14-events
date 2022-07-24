import 'package:equatable/equatable.dart';

typedef OnFav = Function(bool value);

class Favourite extends Equatable {
  final int? id;
  final String? title;
  final String? eventId;
  final String? location;
  final String? eventTime;
  final String? photo;
  const Favourite({
    this.id,
    this.title,
    this.eventId,
    this.location,
    this.eventTime,
    this.photo,
  });

  @override
  List<Object?> get props => [id, title, eventId, location, eventTime, photo];
}
