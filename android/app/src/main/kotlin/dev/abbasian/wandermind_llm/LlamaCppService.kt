package dev.abbasian.wandermind_llm

import android.content.Context
import android.util.Log
import java.io.File

/**
 * Native Android service for llama.cpp integration
 * Provides offline LLM inference using llama.cpp JNI bindings
 */
class LlamaCppService(private val context: Context) {
    
    companion object {
        private const val TAG = "LlamaCppService"
        
        // Load native library
        init {
            try {
                System.loadLibrary("llama-android")
            } catch (e: UnsatisfiedLinkError) {
                Log.e(TAG, "Failed to load native library: ${e.message}")
            }
        }
    }
    
    // Native method declarations
    private external fun nativeInit(modelPath: String, contextSize: Int, threads: Int): Long
    private external fun nativeGenerate(contextPtr: Long, prompt: String, maxTokens: Int, temperature: Float): String
    private external fun nativeGenerateStream(contextPtr: Long, prompt: String, maxTokens: Int, temperature: Float): Array<String>
    private external fun nativeGenerateStreamCallback(contextPtr: Long, prompt: String, maxTokens: Int, temperature: Float, callback: (String) -> Unit)
    private external fun nativeFree(contextPtr: Long)
    private external fun nativeIsLoaded(contextPtr: Long): Boolean
    
    private var contextPtr: Long = 0
    private var isLoaded = false
    private var modelPath: String? = null
    
    /**
     * Load a GGUF model file
     */
    fun loadModel(
        modelPath: String,
        contextSize: Int = 2048,
        threads: Int = 4
    ): Boolean {
        try {
            Log.i(TAG, "Loading model: $modelPath")
            
            // Check if file exists
            val file = File(modelPath)
            if (!file.exists()) {
                Log.e(TAG, "Model file not found: $modelPath")
                return false
            }
            
            // Unload existing model if loaded
            if (isLoaded && contextPtr != 0L) {
                unloadModel()
            }
            
            // Initialize native context
            contextPtr = nativeInit(modelPath, contextSize, threads)
            
            if (contextPtr == 0L) {
                Log.e(TAG, "Failed to initialize native context")
                return false
            }
            
            this.modelPath = modelPath
            isLoaded = true
            
            Log.i(TAG, "Model loaded successfully: $modelPath")
            return true
            
        } catch (e: Exception) {
            Log.e(TAG, "Error loading model: ${e.message}", e)
            return false
        }
    }
    
    /**
     * Generate text response (non-streaming)
     */
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
    
    /**
     * Generate text with streaming (callback for each token)
     */
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
    
    /**
     * Callback function for token streaming from JNI
     */
    @Suppress("unused")
    private fun onTokenGenerated(token: String) {
        // This will be called from JNI for each token
        Log.d(TAG, "Token: $token")
    }
    
    /**
     * Unload the current model
     */
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
    
    /**
     * Check if model is loaded
     */
    fun isModelLoaded(): Boolean {
        return isLoaded && contextPtr != 0L && nativeIsLoaded(contextPtr)
    }
    
    /**
     * Get current model path
     */
    fun getModelPath(): String? {
        return modelPath
    }
}
