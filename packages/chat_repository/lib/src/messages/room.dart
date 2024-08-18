import 'package:equatable/equatable.dart';

enum RoomType { direct, group }

class Room extends Equatable {
  const Room({
    this.createdAt,
    required this.id,
    this.imageUrl,
    this.lastMessage,
    this.metadata,
    this.name,
    required this.type,
    this.updatedAt,
    required this.userIds,
  });

  factory Room.fromMap(Map<String, dynamic> map) {
    final RoomType type = RoomType.values.firstWhere(
      (e) => e.name == map['type'],
    );

    return Room(
      createdAt: map['createdAt'],
      id: map['id'],
      imageUrl: map['imageUrl'],
      lastMessage: map['lastMessage'],
      metadata: map['metadata'],
      name: map['name'],
      type: type,
      updatedAt: map['updatedAt'],
      userIds: ["test1", "test2"],
    );
  }

  final int? createdAt;
  final String id;
  final String? imageUrl;
  final Map<String, dynamic>? lastMessage;
  final Map<String, dynamic>? metadata;
  final String? name;
  final RoomType? type;
  final int? updatedAt;
  final List<String> userIds;

  @override
  List<Object?> get props => [
        createdAt,
        id,
        imageUrl,
        lastMessage,
        metadata,
        name,
        type,
        updatedAt,
        userIds,
      ];

  Room copyWith({
    int? createdAt,
    String? id,
    String? imageUrl,
    Map<String, dynamic>? lastMessage,
    Map<String, dynamic>? metadata,
    String? name,
    RoomType? type,
    int? updatedAt,
    List<String>? userIds,
  }) {
    return Room(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      metadata: metadata ?? this.metadata,
      name: name ?? name,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      userIds: userIds ?? this.userIds,
    );
  }
}
