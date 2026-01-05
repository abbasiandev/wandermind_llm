# WanderMind LLM - AI-Powered Offline Travel Planner

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android-24%2B-3DDC84?logo=android&logoColor=white)](https://www.android.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**Your Personal AI Travel Assistant That Works Completely Offline**

*Intelligent itinerary planning • Smart routing • Voice navigation • Zero internet required*

</div>

## About

**WanderMind LLM** is a revolutionary Flutter-based mobile travel companion that brings the power of Large Language Models (LLM) directly to your device. Unlike traditional travel apps that require constant internet connectivity, WanderMind runs **100% offline** using on-device AI powered by **Llama.cpp**, providing intelligent travel planning, personalized recommendations, and smart navigation even in remote locations.

### Why WanderMind?

- **Complete Privacy**: Your travel data never leaves your device
- **Truly Offline**: Works perfectly without internet connection
- **AI-Powered**: Local LLM provides intelligent travel insights
- **Smart Navigation**: Advanced routing with scenic route options
- **Budget-Friendly**: No API costs, no subscription fees
- **Open Source**: Free and open for everyone

---

## Key Features

### On-Device AI Intelligence
- **Local LLM Integration**: Powered by Llama.cpp with native C++ implementation
- **Smart Travel Assistant**: Conversational AI for travel queries and recommendations
- **Personalized Itineraries**: AI-generated day-by-day travel plans
- **Context-Aware Suggestions**: Understands your preferences and budget
- **Multiple Model Support**: Choose between TinyLlama, Phi-2, and other optimized models

### Advanced Routing & Navigation
- **Smart Routing Engine**: Multi-provider support (OSRM, OpenRouteService, MapBox)
- **Scenic Route Planning**: Algorithm-based scenic path optimization
- **Offline Map Support**: Download and cache map tiles for offline use
- **Multiple Transportation Modes**: Car, bike, walking, and public transport
- **Voice Navigation**: Turn-by-turn voice guidance with Flutter TTS
- **Real-time Location Tracking**: GPS-based location services

### Intelligent Travel Planning
- **Day-by-Day Itineraries**: Detailed plans with time slots and activities
- **Budget Management**: Track expenses with cost breakdowns
- **Interest-Based Planning**: Customize based on your travel interests
- **Activity Categorization**: Sightseeing, food, shopping, entertainment, and more
- **Plan Storage**: Local persistence with Hive database
- **Edit & Share Plans**: Modify and export your travel plans

### Interactive Chat Interface
- **Natural Conversations**: Chat with AI about travel destinations
- **Route Guidance**: "How do I get from Dubai Airport to my hotel?"
- **Local Insights**: Cultural tips, safety advice, and recommendations
- **Multi-turn Context**: AI remembers your conversation history
- **Rich Responses**: Formatted answers with actionable suggestions

### Modern UI/UX
- **Material Design 3**: Beautiful, intuitive interface
- **Dark Mode Support**: Comfortable viewing in any lighting
- **Custom Theming**: Poppins font with carefully crafted color schemes
- **Responsive Design**: Optimized for various screen sizes
- **Smooth Animations**: Polished user experience

---

## Demo

### Screenshots

> Add your app screenshots here to showcase the UI and features

```
[Home Screen] [Chat Interface] [Route Planning] [Itinerary View]
```

### Video Demo

> Add a video demonstration or GIF showcasing key features

---

## Installation

### Prerequisites

- **Flutter SDK**: 3.10 or higher
- **Dart SDK**: 3.0 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK**: API level 24+ (Android 7.0+)
- **NDK**: For native C++ compilation (included in Android Studio)

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/wandermind_llm.git
   cd wandermind_llm
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration (optional)
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

#### Android APK
```bash
flutter build apk --release
```

#### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

---

## Architecture

### Project Structure

```
wandermind_llm/
├── lib/
│   ├── core/                    # Core functionality
│   │   ├── config/              # App configuration
│   │   ├── data/                # Training data & knowledge base
│   │   ├── model/               # Data models (Freezed)
│   │   ├── provider/            # Riverpod providers
│   │   ├── routing/             # GoRouter navigation
│   │   ├── service/             # Core services
│   │   ├── theme/               # App theming
│   │   └── widget/              # Reusable widgets
│   │
│   ├── feature/                 # Feature modules
│   │   ├── chat/                # AI chat interface
│   │   ├── explore/             # Map exploration
│   │   ├── home/                # Dashboard & home
│   │   ├── llm/                 # LLM integration
│   │   ├── location/            # GPS & geolocation
│   │   ├── onboarding/          # First-time user flow
│   │   ├── route/               # Routing & navigation
│   │   ├── setting/             # App settings
│   │   └── travel_plan/         # Trip planning
│   │
│   └── main.dart                # App entry point
│
├── android/                     # Android-specific code
│   └── app/src/main/
│       ├── kotlin/              # Kotlin platform channels
│       │   └── dev/abbasian/wandermind_llm/
│       │       ├── LlamaCppService.kt
│       │       ├── LlamaCppChannel.kt
│       │       └── MainActivity.kt
│       └── cpp/                 # Native C++ LLM integration
│           ├── llama_android.cpp
│           ├── llama.cpp/       # Llama.cpp library
│           └── CMakeLists.txt
│
├── assets/
│   ├── data/                    # Training data
│   ├── images/                  # App images
│   ├── fonts/                   # Custom fonts
│   └── models/                  # LLM models (downloaded)
│
└── test/                        # Unit & widget tests
```

### Tech Stack

#### Frontend
- **Flutter 3.10+**: Cross-platform UI framework
- **Dart 3.0+**: Programming language
- **Material Design 3**: Modern UI components

#### State Management
- **Riverpod 2.4**: Reactive state management
- **Freezed**: Immutable data classes
- **GoRouter**: Declarative routing

#### AI & LLM
- **Llama.cpp**: On-device LLM inference
- **Native C++ Integration**: JNI bindings for Android
- **Platform Channels**: Dart ↔️ Kotlin ↔️ C++ communication
- **Model Support**: TinyLlama, Phi-2, Mistral (GGUF format)

#### Maps & Navigation
- **Flutter Map**: OpenStreetMap integration
- **OpenRouteService**: Routing API
- **OSRM**: Open-source routing engine
- **Offline Routing**: Custom A* algorithm implementation
- **Scenic Routes**: Proprietary scoring algorithm

#### Storage & Persistence
- **Hive**: Fast, lightweight NoSQL database
- **SharedPreferences**: Key-value storage
- **Path Provider**: File system access

#### Location Services
- **Geolocator**: GPS positioning
- **Geocoding**: Address ↔️ coordinates conversion

#### Networking
- **Dio**: HTTP client
- **Connectivity Plus**: Network state monitoring

#### Additional Features
- **Flutter TTS**: Voice navigation
- **Logger**: Structured logging
- **Image Picker**: Photo integration
- **Permission Handler**: Runtime permissions

---

## Configuration

### LLM Model Setup

WanderMind supports multiple LLM models optimized for mobile devices:

| Model | Size | RAM Required | Best For |
|-------|------|--------------|----------|
| TinyLlama 1.1B | ~600MB | 2GB+ | Fast responses, basic queries |
| Phi-2 2.7B | ~1.6GB | 4GB+ | Better reasoning, complex planning |
| Mistral 7B Q4 | ~3.5GB | 6GB+ | Advanced conversations (high-end devices) |

**First Launch**: The app will automatically download the selected model (TinyLlama by default). This may take 5-15 minutes depending on your connection.

### Environment Variables

Create a `.env` file in the root directory:

```env
# Map Configuration
MAPBOX_ACCESS_TOKEN=your_token_here  # Optional: for MapBox tiles
OPENROUTE_API_KEY=your_key_here      # Optional: for OpenRouteService

# LLM Configuration
DEFAULT_MODEL=tinyllama               # Default: tinyllama
CONTEXT_SIZE=2048                     # Context window size
NUM_THREADS=4                         # CPU threads for inference

# Debug
LOG_LEVEL=info                        # debug, info, warning, error
```

---

## Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Tests
```bash
flutter test test/feature/llm/llm_service_test.dart
```

### Coverage Report
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## Performance

### Benchmarks (Mid-range Android Device)

- **LLM Initialization**: 30-45 seconds (first launch)
- **Response Generation**: 2-5 seconds for 100 tokens
- **Route Calculation**: <500ms for typical routes
- **Map Rendering**: 60 FPS with cached tiles
- **Memory Usage**: 300-500MB (TinyLlama loaded)

### Optimization Tips

- Use TinyLlama for devices with <4GB RAM
- Pre-download map tiles for offline areas
- Enable route caching for frequently used paths
- Close other apps for better LLM performance

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
