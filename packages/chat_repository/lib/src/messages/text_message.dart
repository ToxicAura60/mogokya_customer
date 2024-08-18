import 'message.dart';

class TextMessage extends Message {
  const TextMessage({
    required super.id,
    required super.authorId,
    super.createdAt,
    super.metadata,
    super.repliedMessage,
    super.status,
    super.updatedAt,
    required this.text,
  }) : super(type: MessageType.text);

  final String text;

  @override
  Message copyWith({
    String? id,
    String? authorId,
    int? createdAt,
    Map<String, dynamic>? metadata,
    Message? repliedMessage,
    MessageStatus? status,
    String? text,
    int? updatedAt,
  }) {
    return TextMessage(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      metadata: metadata ?? this.metadata,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      text: text ?? this.text,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['authorId'] = authorId;
    map['createdAt'] = createdAt;
    map['metadata'] = metadata;
    map['repliedMessage'] = repliedMessage;
    map['status'] = status;
    map['updatedAt'] = updatedAt;
    map['text'] = text;
    map['type'] = type.name;

    return map;
  }

  factory TextMessage.fromMap(Map<String, dynamic> map) {
    return TextMessage(
      id: map['id'],
      authorId: map['authorId'],
      createdAt: map['createdAt'],
      metadata: map['metadata'],
      repliedMessage: map['repliedMessage'],
      status: map['status'],
      updatedAt: map['updatedAt'],
      text: map['text'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        authorId,
        createdAt,
        metadata,
        repliedMessage,
        status,
        updatedAt,
        text,
      ];
}
