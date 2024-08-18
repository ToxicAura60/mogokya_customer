import 'messages/message.dart';
import 'messages/text_message.dart';
import 'messages/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;

class ChatRepository {
  ChatRepository({
    firebase_firestore.FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore =
            firebaseFirestore ?? firebase_firestore.FirebaseFirestore.instance;

  final firebase_firestore.FirebaseFirestore _firebaseFirestore;

  void createRoom(
    String userId,
    String otherUserId, {
    Map<String, dynamic>? metadata,
  }) async {
    final userIds = [userId, otherUserId]..sort();

    await _firebaseFirestore.collection("rooms").add({
      'createdAt': firebase_firestore.FieldValue.serverTimestamp(),
      'imageUrl': null,
      'metadata': metadata,
      'name': null,
      'type': RoomType.direct.toString(),
      'lastMessage': null,
      'updatedAt': firebase_firestore.FieldValue.serverTimestamp(),
      'userIds': userIds,
    });
  }

  Future<void> deleteMessage(
    String roomId,
    String messageId,
  ) async {
    await _firebaseFirestore
        .collection('rooms/$roomId/messages')
        .doc(messageId)
        .delete();
  }

  Stream<Room> room({
    required String roomId,
    required String uid,
  }) {
    return _firebaseFirestore
        .collection("rooms")
        .doc(roomId)
        .snapshots()
        .asyncMap(
          (doc) => processRoomDocument(doc: doc, uid: uid),
        );
  }

  Future<void> deleteRoom(
    String roomId,
  ) async {
    await _firebaseFirestore.collection('rooms').doc(roomId).delete();
  }

  Stream<List<Message>> messages(
    Room room, {
    int? limit,
  }) {
    var query = _firebaseFirestore
        .collection('rooms/${room.id}/messages')
        .orderBy('createdAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs.fold<List<Message>>(
            [],
            (previousValue, doc) {
              final data = doc.data();

              data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
              data['id'] = doc.id;
              data['updatedAt'] = data['createdAt']?.millisecondsSinceEpoch;
              return [...previousValue, Message.fromMap(data)];
            },
          ),
        );
  }

  Stream<List<Room>> rooms({required String uid}) {
    final collection = _firebaseFirestore
        .collection("rooms")
        .where('userIds', arrayContains: uid)
        .orderBy('updatedAt', descending: true);

    return collection.snapshots().asyncMap((query) async {
      final futures = query.docs.map((doc) {
        return processRoomDocument(doc: doc, uid: uid);
      });

      return await Future.wait(futures);
    });
  }

  void sendMessage({
    required String uid,
    required String roomId,
    required Message message,
  }) async {
    final messageMap = message.toMap();
    messageMap['status'] = MessageStatus.delivered.name;
    messageMap['createdAt'] = firebase_firestore.FieldValue.serverTimestamp();
    messageMap['updatedAt'] = firebase_firestore.FieldValue.serverTimestamp();

    final user = await fetchUser(uid: uid);

    Map<String, dynamic> lastMessage = {
      "authorName":
          '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'.trim(),
    };

    switch (message.type) {
      case MessageType.text:
        lastMessage['lastMessage'] = (message as TextMessage).text;
    }

    await _firebaseFirestore
        .collection('rooms/$roomId/messages')
        .add(messageMap);

    await _firebaseFirestore.collection('rooms').doc(roomId).update({
      'updatedAt': firebase_firestore.FieldValue.serverTimestamp(),
      'lastMessages': lastMessage,
    });
  }

  Future<Map<String, dynamic>> fetchUser({
    required String uid,
  }) async {
    final doc = await _firebaseFirestore.collection("users").doc(uid).get();
    final data = doc.data()!;

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;
    return data;
  }

  Future<Room> processRoomDocument({
    required firebase_firestore.DocumentSnapshot<Map<String, dynamic>> doc,
    required uid,
  }) async {
    final data = doc.data()!;

    String? imageUrl = data['imageUrl'];
    String? name = data['name'];
    List<dynamic> userIds = data['userIds'];
    final String type = data['type'];

    final users = await Future.wait(
      userIds.map(
        (userId) {
          return fetchUser(uid: userId);
        },
      ),
    );

    if (type == RoomType.direct.name) {
      final otherUser = users.firstWhere(
        (u) => u['id'] != uid,
      );
      imageUrl = otherUser['imageUrl'];
      name = '${otherUser['firstName'] ?? ''} ${otherUser['lastName'] ?? ''}'
          .trim();
    }

    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;

    return Room.fromMap(data);
  }
}
