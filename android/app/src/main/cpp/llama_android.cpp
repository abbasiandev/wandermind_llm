#include <jni.h>
#include <string>
#include <vector>
#include <android/log.h>
#include "llama.h"

#define LOG_TAG "LlamaAndroid"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

struct LlamaContext {
    llama_model* model = nullptr;
    llama_context* ctx = nullptr;
    llama_sampler* sampler = nullptr;
};

extern "C" {

JNIEXPORT jlong JNICALL
Java_dev_abbasian_wandermind_1llm_LlamaCppService_nativeInit(
    JNIEnv* env,
    jobject /* this */,
    jstring modelPath,
    jint contextSize,
    jint threads
) {
    const char* path = env->GetStringUTFChars(modelPath, nullptr);
    LOGI("Initializing llama.cpp with model: %s", path);
    LOGI("Context size: %d, Threads: %d", contextSize, threads);
    
    // Check if file exists and is readable
    FILE* test_file = fopen(path, "rb");
    if (!test_file) {
        LOGE("Failed to open model file: %s (errno: %d)", path, errno);
        env->ReleaseStringUTFChars(modelPath, path);
        return 0;
    }
    
    // Get file size
    fseek(test_file, 0, SEEK_END);
    long file_size = ftell(test_file);
    fclose(test_file);
    LOGI("Model file size: %ld bytes (%.2f MB)", file_size, file_size / (1024.0 * 1024.0));
    
    // Minimum valid model size should be at least 100MB
    const long min_model_size = 100 * 1024 * 1024; // 100MB
    if (file_size < min_model_size) {
        LOGE("Model file is too small (%ld bytes = %.2f MB), expected at least 100MB", 
             file_size, file_size / (1024.0 * 1024.0));
        LOGE("This indicates an incomplete or corrupted download. Please re-download the model.");
        env->ReleaseStringUTFChars(modelPath, path);
        return 0;
    }
    
    // Initialize llama backend
    LOGI("Initializing llama backend...");
    llama_backend_init();
    
    // Model parameters
    llama_model_params model_params = llama_model_default_params();
    model_params.n_gpu_layers = 0; // CPU only for Android
    
    // Load model
    LOGI("Loading model from file...");
    llama_model* model = llama_model_load_from_file(path, model_params);
    env->ReleaseStringUTFChars(modelPath, path);
    
    if (!model) {
        LOGE("Failed to load model - llama_model_load_from_file returned null");
        llama_backend_free();
        return 0;
    }
    
    LOGI("Model loaded successfully, creating context...");
    
    // Context parameters
    llama_context_params ctx_params = llama_context_default_params();
    ctx_params.n_ctx = contextSize;
    ctx_params.n_threads = threads;
    ctx_params.n_threads_batch = threads;
    
    // Create context
    llama_context* ctx = llama_init_from_model(model, ctx_params);
    if (!ctx) {
        LOGE("Failed to create context - llama_init_from_model returned null");
        llama_model_free(model);
        llama_backend_free();
        return 0;
    }
    
    LOGI("Context created successfully, creating sampler...");
    
    // Create sampler
    llama_sampler* sampler = llama_sampler_chain_init(llama_sampler_chain_default_params());
    llama_sampler_chain_add(sampler, llama_sampler_init_temp(0.7f));
    llama_sampler_chain_add(sampler, llama_sampler_init_top_k(40));
    llama_sampler_chain_add(sampler, llama_sampler_init_top_p(0.9f, 1));
    llama_sampler_chain_add(sampler, llama_sampler_init_dist(LLAMA_DEFAULT_SEED));
    
    // Create and return context struct
    auto* llama_ctx = new LlamaContext();
    llama_ctx->model = model;
    llama_ctx->ctx = ctx;
    llama_ctx->sampler = sampler;
    
    LOGI("Model initialized successfully - returning context pointer");
    return reinterpret_cast<jlong>(llama_ctx);
}

JNIEXPORT jstring JNICALL
Java_dev_abbasian_wandermind_1llm_LlamaCppService_nativeGenerate(
    JNIEnv* env,
    jobject /* this */,
    jlong contextPtr,
    jstring prompt,
    jint maxTokens,
    jfloat temperature
) {
    auto* llama_ctx = reinterpret_cast<LlamaContext*>(contextPtr);
    if (!llama_ctx || !llama_ctx->ctx) {
        LOGE("Invalid context pointer");
        return env->NewStringUTF("");
    }
    
    const char* prompt_cstr = env->GetStringUTFChars(prompt, nullptr);
    LOGI("Generating text for prompt: %s", prompt_cstr);
    
    // Tokenize prompt
    std::vector<llama_token> tokens;
    tokens.resize(llama_n_ctx(llama_ctx->ctx));
    
    // Get vocab from model
    const llama_vocab* vocab = llama_model_get_vocab(llama_ctx->model);
    
    int n_tokens = llama_tokenize(
        vocab,
        prompt_cstr,
        strlen(prompt_cstr),
        tokens.data(),
        tokens.size(),
        true, // add_bos
        false // special
    );
    env->ReleaseStringUTFChars(prompt, prompt_cstr);
    
    if (n_tokens < 0) {
        LOGE("Failed to tokenize prompt");
        return env->NewStringUTF("");
    }
    
    tokens.resize(n_tokens);
    
    // Decode prompt tokens
    llama_batch batch = llama_batch_get_one(tokens.data(), tokens.size());
    if (llama_decode(llama_ctx->ctx, batch) != 0) {
        LOGE("Failed to decode prompt");
        return env->NewStringUTF("");
    }
    
    // Generate tokens
    std::string response;
    int n_generated = 0;
    
    while (n_generated < maxTokens) {
        // Sample next token
        llama_token new_token = llama_sampler_sample(llama_ctx->sampler, llama_ctx->ctx, -1);
        
        // Get vocab from model
        const llama_vocab* vocab = llama_model_get_vocab(llama_ctx->model);
        
        // Check for EOS
        if (llama_vocab_is_eog(vocab, new_token)) {
            break;
        }
        
        // Convert token to text
        char buf[128];
        int len = llama_token_to_piece(vocab, new_token, buf, sizeof(buf), 0, false);
        if (len > 0) {
            response.append(buf, len);
        }
        
        // Prepare for next iteration
        batch = llama_batch_get_one(&new_token, 1);
        if (llama_decode(llama_ctx->ctx, batch) != 0) {
            LOGE("Failed to decode token");
            break;
        }
        
        n_generated++;
    }
    
    LOGI("Generated %d tokens", n_generated);
    return env->NewStringUTF(response.c_str());
}

JNIEXPORT jobjectArray JNICALL
Java_dev_abbasian_wandermind_1llm_LlamaCppService_nativeGenerateStream(
    JNIEnv* env,
    jobject /* this */,
    jlong contextPtr,
    jstring prompt,
    jint maxTokens,
    jfloat temperature
) {
    auto* llama_ctx = reinterpret_cast<LlamaContext*>(contextPtr);
    if (!llama_ctx || !llama_ctx->ctx) {
        LOGE("Invalid context pointer");
        return env->NewObjectArray(0, env->FindClass("java/lang/String"), nullptr);
    }
    
    const char* prompt_cstr = env->GetStringUTFChars(prompt, nullptr);
    LOGI("Generating streaming text for prompt: %s", prompt_cstr);
    
    // Tokenize prompt
    std::vector<llama_token> tokens;
    tokens.resize(llama_n_ctx(llama_ctx->ctx));
    
    // Get vocab from model
    const llama_vocab* vocab = llama_model_get_vocab(llama_ctx->model);
    
    int n_tokens = llama_tokenize(
        vocab,
        prompt_cstr,
        strlen(prompt_cstr),
        tokens.data(),
        tokens.size(),
        true,
        false
    );
    env->ReleaseStringUTFChars(prompt, prompt_cstr);
    
    if (n_tokens < 0) {
        LOGE("Failed to tokenize prompt");
        return env->NewObjectArray(0, env->FindClass("java/lang/String"), nullptr);
    }
    
    tokens.resize(n_tokens);
    
    // Decode prompt
    llama_batch batch = llama_batch_get_one(tokens.data(), tokens.size());
    if (llama_decode(llama_ctx->ctx, batch) != 0) {
        LOGE("Failed to decode prompt");
        return env->NewObjectArray(0, env->FindClass("java/lang/String"), nullptr);
    }
    
    // Generate and collect tokens
    std::vector<std::string> token_strings;
    int n_generated = 0;
    
    while (n_generated < maxTokens) {
        llama_token new_token = llama_sampler_sample(llama_ctx->sampler, llama_ctx->ctx, -1);
        
        if (llama_vocab_is_eog(vocab, new_token)) {
            break;
        }
        
        char buf[128];
        int len = llama_token_to_piece(vocab, new_token, buf, sizeof(buf), 0, false);
        if (len > 0) {
            token_strings.push_back(std::string(buf, len));
        }
        
        batch = llama_batch_get_one(&new_token, 1);
        if (llama_decode(llama_ctx->ctx, batch) != 0) {
            break;
        }
        
        n_generated++;
    }
    
    // Convert to Java array
    jobjectArray result = env->NewObjectArray(
        token_strings.size(),
        env->FindClass("java/lang/String"),
        nullptr
    );
    
    for (size_t i = 0; i < token_strings.size(); i++) {
        env->SetObjectArrayElement(result, i, env->NewStringUTF(token_strings[i].c_str()));
    }
    
    LOGI("Generated %d tokens for streaming", n_generated);
    return result;
}

JNIEXPORT void JNICALL
Java_dev_abbasian_wandermind_1llm_LlamaCppService_nativeGenerateStreamCallback(
    JNIEnv* env,
    jobject thiz,
    jlong contextPtr,
    jstring prompt,
    jint maxTokens,
    jfloat temperature,
    jobject callback
) {
    auto* llama_ctx = reinterpret_cast<LlamaContext*>(contextPtr);
    if (!llama_ctx || !llama_ctx->ctx) {
        LOGE("Invalid context pointer");
        return;
    }
    
    const char* prompt_cstr = env->GetStringUTFChars(prompt, nullptr);
    LOGI("Generating streaming text with callback for prompt length: %d", strlen(prompt_cstr));
    
    // Tokenize prompt
    std::vector<llama_token> tokens;
    tokens.resize(llama_n_ctx(llama_ctx->ctx));
    
    // Get vocab from model
    const llama_vocab* vocab = llama_model_get_vocab(llama_ctx->model);
    
    int n_tokens = llama_tokenize(
        vocab,
        prompt_cstr,
        strlen(prompt_cstr),
        tokens.data(),
        tokens.size(),
        true,
        false
    );
    env->ReleaseStringUTFChars(prompt, prompt_cstr);
    
    if (n_tokens < 0) {
        LOGE("Failed to tokenize prompt");
        return;
    }
    
    tokens.resize(n_tokens);
    
    // Decode prompt
    llama_batch batch = llama_batch_get_one(tokens.data(), tokens.size());
    if (llama_decode(llama_ctx->ctx, batch) != 0) {
        LOGE("Failed to decode prompt");
        return;
    }
    
    // Get the callback's invoke method (Kotlin lambda)
    jclass callbackClass = env->GetObjectClass(callback);
    jmethodID invokeMethod = env->GetMethodID(callbackClass, "invoke", "(Ljava/lang/Object;)Ljava/lang/Object;");
    
    if (!invokeMethod) {
        LOGE("Failed to get invoke method");
        return;
    }
    
    // Generate tokens and call callback for each one
    int n_generated = 0;
    
    while (n_generated < maxTokens) {
        llama_token new_token = llama_sampler_sample(llama_ctx->sampler, llama_ctx->ctx, -1);
        
        if (llama_vocab_is_eog(vocab, new_token)) {
            break;
        }
        
        char buf[128];
        int len = llama_token_to_piece(vocab, new_token, buf, sizeof(buf), 0, false);
        if (len > 0) {
            // Call the Kotlin callback with the token
            jstring tokenStr = env->NewStringUTF(std::string(buf, len).c_str());
            env->CallObjectMethod(callback, invokeMethod, tokenStr);
            env->DeleteLocalRef(tokenStr);
            
            // Check for exceptions
            if (env->ExceptionCheck()) {
                LOGE("Exception in callback");
                env->ExceptionClear();
                break;
            }
        }
        
        batch = llama_batch_get_one(&new_token, 1);
        if (llama_decode(llama_ctx->ctx, batch) != 0) {
            break;
        }
        
        n_generated++;
    }
    
    LOGI("Generated %d tokens with callback", n_generated);
}

JNIEXPORT void JNICALL
Java_dev_abbasian_wandermind_1llm_LlamaCppService_nativeFree(
    JNIEnv* env,
    jobject /* this */,
    jlong contextPtr
) {
    auto* llama_ctx = reinterpret_cast<LlamaContext*>(contextPtr);
    if (llama_ctx) {
        LOGI("Freeing llama context");
        
        if (llama_ctx->sampler) {
            llama_sampler_free(llama_ctx->sampler);
        }
        if (llama_ctx->ctx) {
            llama_free(llama_ctx->ctx);
        }
        if (llama_ctx->model) {
            llama_model_free(llama_ctx->model);
        }
        
        delete llama_ctx;
        llama_backend_free();
    }
}

JNIEXPORT jboolean JNICALL
Java_dev_abbasian_wandermind_1llm_LlamaCppService_nativeIsLoaded(
    JNIEnv* env,
    jobject /* this */,
    jlong contextPtr
) {
    auto* llama_ctx = reinterpret_cast<LlamaContext*>(contextPtr);
    return (llama_ctx && llama_ctx->ctx && llama_ctx->model) ? JNI_TRUE : JNI_FALSE;
}

} // extern "C"
