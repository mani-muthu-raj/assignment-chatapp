import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/message_list_viewmodel.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final chatId = args['chatId'] as String;
    final userName = args['userName'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        backgroundColor: Colors.teal,
        elevation: 1,
      ),
      body: ChangeNotifierProvider(
        create: (_) => MessageListViewModel()..loadMessages(chatId),
        child: Consumer<MessageListViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Scroll to bottom after messages are loaded
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(
                  _scrollController.position.maxScrollExtent,
                );
              }
            });

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: vm.messages.length,
                    itemBuilder: (context, index) {
                      final msg = vm.messages[index];
                      final isMine = msg.isMine;

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Align(
                          alignment: isMine
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isMine ? Colors.teal : Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft: Radius.circular(isMine ? 12 : 0),
                                  bottomRight: Radius.circular(isMine ? 0 : 12),
                                ),
                              ),
                              child: Text(
                                msg.content,
                                style: TextStyle(
                                  color: isMine ? Colors.white : Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Input area
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.teal,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            if (_controller.text.trim().isEmpty) return;

                            Provider.of<MessageListViewModel>(
                              context,
                              listen: false,
                            ).sendMessage( chatId, _controller.text.trim());

                            _controller.clear();

                            // Scroll after sending
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (_scrollController.hasClients) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
