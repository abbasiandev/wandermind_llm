import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wandermind_llm/feature/llm/provider/llm_provider.dart';

import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/loading_widget.dart';
import '../provider/chat_provider.dart';
import '../widget/chat_input.dart';
import '../widget/chat_message_bubble.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatAsync = ref.watch(chatControllerProvider);
    final llmState = ref.watch(lLMControllerProvider);
    final chatInputState = ref.watch(chatInputControllerProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Travel Assistant',
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'clear':
                  _showClearChatDialog();
                  break;
                case 'export':
                  _exportChat();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.clear_all),
                    SizedBox(width: 8),
                    Text('Clear Chat'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Export Chat'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [

          if (!llmState.isInitialized)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.errorContainer,
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AI assistant is initializing... Please wait.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                  if (llmState.isLoading)
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        value: llmState.initializationProgress > 0
                            ? llmState.initializationProgress
                            : null,
                      ),
                    ),
                ],
              ),
            ),

          Expanded(
            child: chatAsync.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return _buildEmptyChat();
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ChatMessageBubble(
                        message: message,
                        onTravelPlanTap: message.metadata?['planId'] != null
                            ? () {
                          final planId = message.metadata!['planId'] as String;
                          context.go('/plan/$planId');
                        }
                            : null,
                      ),
                    );
                  },
                );
              },
              loading: () => const LoadingWidget(),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load chat',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(chatControllerProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ChatInput(
            message: chatInputState.message,
            isLoading: chatInputState.isLoading || llmState.isGenerating,
            enabled: llmState.isInitialized,
            onMessageChanged: (message) {
              ref.read(chatInputControllerProvider.notifier).updateMessage(message);
            },
            onSendMessage: (message) async {
              ref.read(chatInputControllerProvider.notifier).clearMessage();
              await ref.read(chatControllerProvider.notifier).sendMessage(message);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome to WanderMind!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'I\'m your AI travel assistant. Ask me anything about travel planning!',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Text(
                    ' Try asking me:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildSuggestionChip('How to get from Dubai Airport to my hotel?'),
                      _buildSuggestionChip('What are the best places to visit in Dubai?'),
                      _buildSuggestionChip('How much does a trip to Japan cost?'),
                      _buildSuggestionChip('Best transportation in Tokyo?'),
                      _buildSuggestionChip('What should I pack for a beach vacation?'),
                      _buildSuggestionChip('Best time to visit Europe?'),
                      _buildSuggestionChip('Tips for solo female travelers'),
                      _buildSuggestionChip('Cultural etiquette in Arab countries'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String suggestion) {
    return ActionChip(
      label: Text(
        suggestion,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onPressed: () async {
        ref.read(chatInputControllerProvider.notifier).updateMessage(suggestion);

        await ref.read(chatControllerProvider.notifier).sendMessage(suggestion);
        ref.read(chatInputControllerProvider.notifier).clearMessage();
      },
    );
  }

  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat'),
        content: const Text('Are you sure you want to clear all chat messages? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(chatControllerProvider.notifier).clearChat();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _exportChat() {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export feature coming soon!')),
    );
  }
}
