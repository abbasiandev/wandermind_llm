package dev.abbasian.wandermind_llm

import android.content.Context
import android.util.Log
import java.io.File

class LlamaCppService(private val context: Context) {

    companion object {
        private const val TAG = "LlamaCppService"

        init {
            try {
                System.loadLibrary("llama-android")
            } catch (e: UnsatisfiedLinkError) {
                Log.e(TAG, "Failed to load native library: ${e.message}")
            }
        }
    }

    private external fun nativeInit(modelPath: String, contextSize: Int, threads: Int): Long
    private external fun nativeGenerate(contextPtr: Long, prompt: String, maxTokens: Int, temperature: Float): String
    private external fun nativeGenerateStream(contextPtr: Long, prompt: String, maxTokens: Int, temperature: Float): Array<String>
    private external fun nativeGenerateStreamCallback(contextPtr: Long, prompt: String, maxTokens: Int, temperature: Float, callback: (String) -> Unit)
    private external fun nativeFree(contextPtr: Long)
    private external fun nativeIsLoaded(contextPtr: Long): Boolean

    private var contextPtr: Long = 0
    private var isLoaded = false
    private var modelPath: String? = null

    fun loadModel(
        modelPath: String,
        contextSize: Int = 2048,
        threads: Int = 4
    ): Boolean {
        try {
            Log.i(TAG, "Loading model: $modelPath")

            val file = File(modelPath)
            if (!file.exists()) {
                Log.e(TAG, "Model file not found: $modelPath")
                return false
            }

            // Log detailed file information
            Log.i(TAG, "Model file exists: ${file.exists()}")
            Log.i(TAG, "Model file size: ${file.length()} bytes")
            Log.i(TAG, "Model file can read: ${file.canRead()}")
            Log.i(TAG, "Model file absolute path: ${file.absolutePath}")

            if (isLoaded && contextPtr != 0L) {
                unloadModel()
            }

            Log.i(TAG, "Calling nativeInit with contextSize=$contextSize, threads=$threads")
            contextPtr = nativeInit(modelPath, contextSize, threads)

            if (contextPtr == 0L) {
                Log.e(TAG, "Failed to initialize native context - nativeInit returned 0")
                return false
            }

            this.modelPath = modelPath
            isLoaded = true

            Log.i(TAG, "Model loaded successfully: $modelPath")
            return true

        } catch (e: Exception) {
            Log.e(TAG, "Error loading model: ${e.message}", e)
            e.printStackTrace()
            return false
        }
    }

    fun generateText(
        prompt: String,
        maxTokens: Int = 512,
        temperature: Float = 0.7f
    ): String {
        if (!isLoaded || contextPtr == 0L) {
            throw IllegalStateException("Model not loaded")
        }

        try {
            Log.d(TAG, "Generating text for prompt length: ${prompt.length}")
            val response = nativeGenerate(contextPtr, prompt, maxTokens, temperature)
            Log.d(TAG, "Generated response length: ${response.length}")
            return response
        } catch (e: Exception) {
            Log.e(TAG, "Error generating text: ${e.message}", e)
            throw e
        }
    }

    fun generateTextStream(
        prompt: String,
        maxTokens: Int = 512,
        temperature: Float = 0.7f,
        onToken: (String) -> Unit
    ) {
        if (!isLoaded || contextPtr == 0L) {
            throw IllegalStateException("Model not loaded")
        }

        try {
            Log.d(TAG, "Generating streaming text for prompt length: ${prompt.length}")
            nativeGenerateStreamCallback(contextPtr, prompt, maxTokens, temperature, onToken)
        } catch (e: Exception) {
            Log.e(TAG, "Error generating streaming text: ${e.message}", e)
            throw e
        }
    }

    @Suppress("unused")
    private fun onTokenGenerated(token: String) {

        Log.d(TAG, "Token: $token")
    }

    fun unloadModel() {
        if (isLoaded && contextPtr != 0L) {
            try {
                Log.i(TAG, "Unloading model...")
                nativeFree(contextPtr)
                contextPtr = 0
                isLoaded = false
                modelPath = null
                Log.i(TAG, "Model unloaded successfully")
            } catch (e: Exception) {
                Log.e(TAG, "Error unloading model: ${e.message}", e)
            }
        }
    }

    fun isModelLoaded(): Boolean {
        return isLoaded && contextPtr != 0L && nativeIsLoaded(contextPtr)
    }

    fun getModelPath(): String? {
        return modelPath
    }
}
