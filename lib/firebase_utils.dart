import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/my_user.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (myUser, options) => myUser.toJson(),
        );
  }

  static Future<void> addUserInFirestore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> getUserInFirestore(String eventId) async {
    DocumentSnapshot<MyUser> documentSnapshot = await getUsersCollection()
        .doc(eventId)
        .get();
    return documentSnapshot.data();
  }

  static CollectionReference<Event> getEventsCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );
  }

  static Future<void> addEventInFirestore(Event event, String uId) {
    DocumentReference<Event> documentReference = getEventsCollection(uId).doc();
    event.eventId = documentReference.id;
    return documentReference.set(event);
  }

  static Stream<List<Event>> getAllEventsInFirestore(String uId) {
    Stream<QuerySnapshot<Event>> stream = getEventsCollection(
      uId,
    ).orderBy('date_time').snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Stream<List<Event>> getEventsByFilterInFirestore(
    int index,
    String uId,
  ) {
    Stream<QuerySnapshot<Event>> stream = getEventsCollection(uId)
        .where('event_category_index', isEqualTo: index)
        .orderBy('date_time')
        .snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Future<void> addFavoriteEventInFirestore(Event event, String uId) {
    return getEventsCollection(
      uId,
    ).doc(event.eventId).update({"is_favorite": !event.isFavorite});
  }

  static Stream<List<Event>> getEventsFavoriteInFirestore(String uId) {
    Stream<QuerySnapshot<Event>> stream = getEventsCollection(
      uId,
    ).where('is_favorite', isEqualTo: true).snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Stream<Event?> getEventByIdInFirebase(String eventId, String uId) {
    return getEventsCollection(uId).doc(eventId).snapshots().map((event) {
      return event.data();
    });
  }

  static Future<void> updateEventInFirestore(Event event, String uId) {
    return getEventsCollection(uId).doc(event.eventId).update({
      "image": event.image,
      "event_category_index": event.eventCategoryIndex,
      "title": event.title,
      "description": event.description,
      "date_time": event.dateTime,
    });
  }

  static Future<void> deleteEventInFirestore(String eventId, String uId) {
    return getEventsCollection(uId).doc(eventId).delete();
  }
}
