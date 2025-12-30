import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/llm_di_provider.dart';

/// Observes app lifecycle to properly manage LLM resources
/// This ensures models are unloaded when app is paused to save memory
class AppLifecycleObserver extends WidgetsBindingObserver {
  final WidgetRef ref;
  
  AppLifecycleObserver(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    switch (state) {
      case AppLifecycleState.paused:
        // App is going to background - optionally unload model to save memory
        _handleAppPaused();
        break;
      case AppLifecycleState.resumed:
        // App is coming back to foreground
        _handleAppResumed();
        break;
      case AppLifecycleState.detached:
        // App is being terminated - cleanup resources
        _handleAppDetached();
        break;
      default:
        break;
    }
  }

  void _handleAppPaused() {
    // Optionally unload model when app goes to background
    // This saves memory but requires reloading when app resumes
    // Uncomment if you want this behavior:
    // final service = ref.read(llmServiceProvider);
    // service.dispose();
  }

  void _handleAppResumed() {
    // App resumed - model will be reloaded when needed
  }

  void _handleAppDetached() {
    // App is terminating - cleanup all LLM resources
    final service = ref.read(llmServiceProvider);
    service.dispose();
  }
}

/// Provider-aware widget that manages app lifecycle
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
