import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.userImage,
      required this.userName})
      : super(key: key);

  final String message;
  final String userName;
  final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      color: Colors.black87,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color:
                      isMe ? const Color(0xff4D0B0B) : const Color(0xff5E5553),
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(32),
                    topLeft: const Radius.circular(32),
                    bottomLeft: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(32),
                    bottomRight: isMe
                        ? const Radius.circular(32)
                        : const Radius.circular(0),
                  ),
                ),
                width: (userName.length > 28||message.length>70)
                    ? MediaQuery.of(context).size.width * 0.70
                    : (userName.length > message.length)
                        ? (userName.length < 15)
                            ? MediaQuery.of(context).size.width * 0.50
                            : MediaQuery.of(context).size.width * 0.60
                        : (message.length < 40)
                            ? MediaQuery.of(context).size.width * 0.50
                            : MediaQuery.of(context).size.width * 0.60,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SelectableText(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: -5,
            right: isMe ? null : (userName.length > 28||message.length>70)
                ? MediaQuery.of(context).size.width * 0.66
                : (userName.length > message.length)
                ? (userName.length < 15)
                ? MediaQuery.of(context).size.width * 0.46
                : MediaQuery.of(context).size.width * 0.56
                : (message.length < 40)
                ? MediaQuery.of(context).size.width * 0.46
                : MediaQuery.of(context).size.width * 0.56,
            left: isMe ? (userName.length > 28||message.length>70)
                ? MediaQuery.of(context).size.width * 0.66
                : (userName.length > message.length)
                ? (userName.length < 15)
                ? MediaQuery.of(context).size.width * 0.46
                : MediaQuery.of(context).size.width * 0.56
                : (message.length < 40)
                ? MediaQuery.of(context).size.width * 0.46
                : MediaQuery.of(context).size.width * 0.56 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ),
          ),
        ],
      ),
    );
  }
}
