import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Lấy dữ liệu từ Firestore collection "chat"
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),

      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        // Hiện loading khi chưa lấy được dữ liệu
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Lấy danh sách documents
        final chatDocs = chatSnapshot.data!.docs;

        // Hiển thị danh sách tin nhắn
        return ListView.builder(
          reverse: true, // tin mới ở dưới cùng
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['userId'] ==
                FirebaseAuth.instance.currentUser!.uid, // kiểm tra người gửi
            chatDocs[index]['userId'], // UID người gửi
            (chatDocs[index]['createdAt'] as Timestamp).toDate(), // thời gian gửi
          ),
        );
      },
    );
  }
}
