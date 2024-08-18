import 'package:app1/app/app.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: const Text(
          "Chat",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<List<Room>>(
        stream: ChatRepository().rooms(
          uid: context.read<AppBloc>().state.user.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingAnimationWidget.hexagonDots(
              color: Colors.red,
              size: 20,
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text("kosong");
          }
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.red,
                ),
                title: Text(
                  "${room.name}",
                ),
                subtitle: room.lastMessage == null
                    ? null
                    : Text("${room.lastMessage!['text']}"),
                onTap: () {
                  context.go("/chat/${room.id}");
                },
              );
            },
          );
        },
      ),
    );
  }
}
