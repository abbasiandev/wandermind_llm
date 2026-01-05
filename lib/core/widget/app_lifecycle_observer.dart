import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/llm_di_provider.dart';
class AppLifecycleObserver extends WidgetsBindingObserver {
  final WidgetRef ref;
  AppLifecycleObserver(this.ref);
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        _handleAppPaused();
        break;
      case AppLifecycleState.resumed:
        _handleAppResumed();
        break;
      case AppLifecycleState.detached:
        _handleAppDetached();
        break;
      default:
        break;
    }
  }
  void _handleAppPaused() {
  }
  void _handleAppResumed() {
  }
  void _handleAppDetached() {
    final service = ref.read(llmServiceProvider);
    service.dispose();
  }
}
class AppLifecycleManager extends ConsumerStatefulWidget {
  final Widget child;
  const AppLifecycleManager({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  ConsumerState<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}
class _AppLifecycleManagerState extends ConsumerState<AppLifecycleManager> {
  late AppLifecycleObserver _observer;
  @override
  void initState() {
    super.initState();
    _observer = AppLifecycleObserver(ref);
    WidgetsBinding.instance.addObserver(_observer);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_observer);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}