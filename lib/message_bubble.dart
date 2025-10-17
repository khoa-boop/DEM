import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;      // Nội dung tin nhắn
  final bool isMe;           // Có phải tin nhắn của mình không
  final String userId;       // UID của người gửi
  final DateTime timestamp;  // Thời gian gửi

  const MessageBubble(
    this.message,
    this.isMe,
    this.userId,
    this.timestamp, {
    super.key,
  });

  // Hàm định dạng thời gian theo dạng 12h + AM/PM
  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = timestamp.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _formatTimestamp(timestamp);

    return Row(
      mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[300] : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 250, // tăng kích thước hiển thị
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // UID người gửi
              Text(
                userId,
                style: const TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),

              // Nội dung tin nhắn
              Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 8),

              // Thời gian gửi
              Text(
                formattedTime,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
