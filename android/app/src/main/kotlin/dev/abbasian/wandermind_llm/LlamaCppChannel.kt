package dev.abbasian.wandermind_llm

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*

class LlamaCppChannel(private val context: Context) {

    companion object {
        private const val TAG = "LlamaCppChannel"
        const val METHOD_CHANNEL = "dev.abbasian.wandermind/llama_cpp"
        const val EVENT_CHANNEL = "dev.abbasian.wandermind/llama_cpp_stream"
    }

    private val llamaService = LlamaCppService(context)
    private val scope = CoroutineScope(Dispatchers.Default + SupervisorJob())
    private val mainHandler = Handler(Looper.getMainLooper())

    fun handleMethodCall(call: io.flutter.plugin.common.MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "loadModel" -> {
                val modelPath = call.argument<String>("modelPath")
                val contextSize = call.argument<Int>("contextSize") ?: 2048
                val threads = call.argument<Int>("threads") ?: 4

                if (modelPath == null) {
                    result.error("INVALID_ARGUMENT", "Model path is required", null)
                    return
                }

                scope.launch {
                    try {
                        val success = llamaService.loadModel(modelPath, contextSize, threads)
                        mainHandler.post {
                            result.success(success)
                        }
                    } catch (e: Exception) {
                        mainHandler.post {
                            result.error("LOAD_ERROR", e.message, null)
                        }
                    }
                }
            }

            "generateText" -> {
                val prompt = call.argument<String>("prompt")
                val maxTokens = call.argument<Int>("maxTokens") ?: 512
                val temperature = call.argument<Double>("temperature")?.toFloat() ?: 0.7f

                if (prompt == null) {
                    result.error("INVALID_ARGUMENT", "Prompt is required", null)
                    return
                }

                scope.launch {
                    try {
                        val response = llamaService.generateText(prompt, maxTokens, temperature)
                        mainHandler.post {
                            result.success(response)
                        }
                    } catch (e: Exception) {
                        mainHandler.post {
                            result.error("GENERATE_ERROR", e.message, null)
                        }
                    }
                }
            }

            "isModelLoaded" -> {
                result.success(llamaService.isModelLoaded())
            }

            "getModelPath" -> {
                result.success(llamaService.getModelPath())
            }

            "unloadModel" -> {
                scope.launch {
                    try {
                        llamaService.unloadModel()
                        mainHandler.post {
                            result.success(true)
                        }
                    } catch (e: Exception) {
                        mainHandler.post {
                            result.error("UNLOAD_ERROR", e.message, null)
                        }
                    }
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    fun getStreamHandler(): EventChannel.StreamHandler {
        return object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                if (events == null) return

                val args = arguments as? Map<*, *>
                val prompt = args?.get("prompt") as? String
                val maxTokens = args?.get("maxTokens") as? Int ?: 512
                val temperature = (args?.get("temperature") as? Double)?.toFloat() ?: 0.7f

                if (prompt == null) {
                    events.error("INVALID_ARGUMENT", "Prompt is required", null)
                    return
                }

                scope.launch(Dispatchers.IO) {
                    try {
                        llamaService.generateTextStream(prompt, maxTokens, temperature) { token ->

                            mainHandler.post {
                                events.success(token)
                            }
                        }
                        mainHandler.post {
                            events.endOfStream()
                        }
                    } catch (e: Exception) {
                        Log.e(TAG, "Stream error: ${e.message}", e)
                        mainHandler.post {
                            events.error("STREAM_ERROR", e.message, null)
                        }
                    }
                }
            }

            override fun onCancel(arguments: Any?) {

            }
        }
    }

    fun dispose() {
        scope.cancel()
        llamaService.unloadModel()
    }
}
