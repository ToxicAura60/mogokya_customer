import 'text_message.dart';
import 'package:equatable/equatable.dart';

enum MessageType {
  text,
}

enum MessageStatus { delivered, error, seen, sending, sent }

abstract class Message extends Equatable {
  const Message({
    required this.id,
    required this.authorId,
    this.createdAt,
    this.metadata,
    this.repliedMessage,
    this.status,
    this.updatedAt,
    required this.type,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    final type = MessageType.values.firstWhere(
      (e) => e.name == map['type'],
    );

    switch (type) {
      case MessageType.text:
        return TextMessage.fromMap(map);
    }
  }

  final String id;
  final String authorId;
  final int? createdAt;
  final Map<String, dynamic>? metadata;
  final Message? repliedMessage;
  final MessageStatus? status;
  final MessageType type;
  final int? updatedAt;

  Message copyWith({
    String? authorId,
    int? createdAt,
    Map<String, dynamic>? metadata,
    Message? repliedMessage,
    MessageStatus? status,
    int? updatedAt,
  });

  Map<String, dynamic> toMap();
}
