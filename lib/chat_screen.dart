import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController(); // điều khiển text input
  String _enteredMessage = ''; // lưu nội dung tin nhắn

  // Hàm gửi tin nhắn lên Firestore
  void _sendMessage() async {
    FocusScope.of(context).unfocus(); // ẩn bàn phím
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage.trim(),
      'createdAt': Timestamp.now(),
      'userId': user?.uid,
    });
    _controller.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FA),
      appBar: AppBar(
        title: const Text('Firebase Chat'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          // Danh sách tin nhắn
          const Expanded(child: Messages()),

          // Ô nhập tin nhắn
          Container(
            margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _enteredMessage = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.indigo),
                  onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
