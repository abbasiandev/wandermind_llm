import 'package:flutter/material.dart';
import '../../../core/theme/app_color.dart';

class ChatInput extends StatefulWidget {
  final String message;
  final bool isLoading;
  final bool enabled;
  final Function(String) onMessageChanged;
  final Function(String) onSendMessage;

  const ChatInput({
    super.key,
    required this.message,
    required this.isLoading,
    required this.enabled,
    required this.onMessageChanged,
    required this.onSendMessage,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.message;
    _controller.addListener(() {
      widget.onMessageChanged(_controller.text);
    });
  }

  @override
  void didUpdateWidget(ChatInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message != oldWidget.message) {
      _controller.text = widget.message;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isNotEmpty && widget.enabled && !widget.isLoading) {
      widget.onSendMessage(message);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canSend = widget.message.trim().isNotEmpty &&
        widget.enabled &&
        !widget.isLoading;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          // Attachment button (future feature)
          IconButton(
            onPressed: widget.enabled ? _showAttachmentOptions : null,
            icon: const Icon(Icons.attach_file),
            tooltip: 'Attach file',
          ),

          const SizedBox(width: 8),

          // Text input
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              maxLines: null,
              minLines: 1,
              textInputAction: TextInputAction.send,
              onSubmitted: widget.enabled ? (_) => _sendMessage() : null,
              decoration: InputDecoration(
                hintText: widget.enabled
                    ? 'Ask me about travel plans...'
                    : 'AI assistant is initializing...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                suffixIcon: widget.isLoading
                    ? Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.all(12),
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
                    : null,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send button
          FloatingActionButton.small(
            onPressed: canSend ? _sendMessage : null,
            backgroundColor: canSend
                ? AppColors.primary
                : theme.disabledColor,
            child: Icon(
              Icons.send,
              color: canSend
                  ? Colors.white
                  : theme.colorScheme.onBackground.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Photo'),
              onTap: () {
                Navigator.pop(context);
                // Implement photo attachment
                _showComingSoonSnackBar('Photo attachment');
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Location'),
              onTap: () {
                Navigator.pop(context);
                // Implement location sharing
                _showComingSoonSnackBar('Location sharing');
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Document'),
              onTap: () {
                Navigator.pop(context);
                // Implement document attachment
                _showComingSoonSnackBar('Document attachment');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoonSnackBar(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}