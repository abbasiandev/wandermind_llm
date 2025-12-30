package dev.abbasian.wandermind_llm

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    
    private var llamaChannel: LlamaCppChannel? = null
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Initialize llama.cpp channel
        llamaChannel = LlamaCppChannel(applicationContext)
        
        // Setup method channel
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            LlamaCppChannel.METHOD_CHANNEL
        ).setMethodCallHandler { call, result ->
            llamaChannel?.handleMethodCall(call, result)
        }
        
        // Setup event channel for streaming
        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            LlamaCppChannel.EVENT_CHANNEL
        ).setStreamHandler(llamaChannel?.getStreamHandler())
    }
    
    override fun onDestroy() {
        llamaChannel?.dispose()
        llamaChannel = null
        super.onDestroy()
    }
}
