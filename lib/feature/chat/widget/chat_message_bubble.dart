import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/model/app_model.dart';
import '../../../core/theme/app_color.dart';
class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onTravelPlanTap;
  const ChatMessageBubble({
    super.key,
    required this.message,
    this.onTravelPlanTap,
  });
  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final theme = Theme.of(context);
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomRight: isUser ? const Radius.circular(4) : null,
                  bottomLeft: !isUser ? const Radius.circular(4) : null,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.type == MessageType.travelPlan)
                    _buildTravelPlanPreview(context)
                  else
                    _buildTextMessage(context, isUser),
                  if (!isUser && _isRoutingResponse(message.content))
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: _buildRouteButton(context),
                    ),
                  if (!isUser)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 16),
                          onPressed: () => _copyMessage(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _formatTime(message.timestamp),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextMessage(BuildContext context, bool isUser) {
    final theme = Theme.of(context);
    return SelectableText(
      message.content,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: isUser
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurface,
      ),
    );
  }
  Widget _buildTravelPlanPreview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.map,
                color: AppColors.accent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message.content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: onTravelPlanTap,
            icon: const Icon(Icons.visibility, size: 16),
            label: const Text('View Plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              minimumSize: Size.zero,
            ),
          ),
        ],
      ),
    );
  }
  void _copyMessage(BuildContext context) {
    Clipboard.setData(ClipboardData(text: message.content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
  bool _isRoutingResponse(String content) {
    final routingKeywords = [
      'route',
      'get from',
      'how to get',
      'directions',
      'navigate',
      'transportation',
      'taxi',
      'metro',
      'bus',
      'show route on map',
      'airport to',
    ];
    final contentLower = content.toLowerCase();
    return routingKeywords.any((keyword) => contentLower.contains(keyword));
  }
  Widget _buildRouteButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          context.push('/route');
        },
        icon: const Icon(Icons.map, size: 18),
        label: const Text('Show Route on Map'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}