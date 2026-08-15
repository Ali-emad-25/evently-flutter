import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = 'Events';

  String eventId;
  Map<String, dynamic> image;
  int eventCategoryIndex;
  String title;
  String description;
  DateTime dateTime;
  bool isFavorite;

  Event({
    this.eventId = '',
    required this.image,
    required this.eventCategoryIndex,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "event_id": eventId,
      "image": image,
      "event_category_index": eventCategoryIndex,
      "title": title,
      "description": description,
      "date_time": dateTime,
      "is_favorite": isFavorite,
    };
  }

  Event.fromJson(Map<String, dynamic> json)
    : this(
        eventId: json['event_id'],
        image: json['image'],
        eventCategoryIndex: json['event_category_index'],
        title: json['title'],
        description: json['description'],
        dateTime: (json['date_time'] as Timestamp).toDate(),
        isFavorite: json['is_favorite'],
      );
}
