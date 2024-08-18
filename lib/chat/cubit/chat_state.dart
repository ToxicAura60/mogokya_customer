part of 'chat_cubit.dart';

class ChatState extends Equatable {
  ChatState({
    this.roomId = "",
  });

  final String roomId;

  ChatState copyWith({
    String? roomId,
  }) {
    return ChatState(
      roomId: roomId ?? this.roomId,
    );
  }

  @override
  List<Object> get props => [roomId];
}
