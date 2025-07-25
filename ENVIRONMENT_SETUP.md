# Environment Setup for AI API Keys

This project uses `--dart-define-from-file` to securely manage API keys for AI services.

## Setup Instructions

### 1. Create environment.json file
Copy the example file and add your API keys:

```bash
cp environment.example.json environment.json
```

### 2. Add your API keys
Edit `environment.json` with your actual API keys:

```json
{
  "OPENAI_API_KEY": "sk-your-actual-openai-api-key-here",
  "ANTHROPIC_API_KEY": "sk-ant-your-actual-claude-api-key-here"
}
```

### 3. Run the app with environment variables

#### Flutter Run
```bash
flutter run --dart-define-from-file=environment.json
```

#### Flutter Build
```bash
flutter build apk --dart-define-from-file=environment.json
flutter build ios --dart-define-from-file=environment.json
```

#### VS Code Launch Configuration
Add this to your `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Launch with Environment",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": [
        "--dart-define-from-file=environment.json"
      ]
    }
  ]
}
```

#### Android Studio Run Configuration
1. Go to Run → Edit Configurations
2. Select your Flutter configuration 
3. In "Additional run args", add: `--dart-define-from-file=environment.json`

## Security Notes

⚠️ **Important**: 
- `environment.json` is added to `.gitignore` and should **never** be committed
- Only commit `environment.example.json` with placeholder values
- Each developer should create their own `environment.json` file locally

## API Key Sources (Priority Order)

The app will look for API keys in this order:
1. **Parameter passed to method** (highest priority)
2. **`--dart-define-from-file`** (recommended)
3. **System environment variables** (fallback)

Example:
```dart
// Method parameter (highest priority)
await promptManager.callOpenAIPrompt(
  userPrompt: "Hello",
  apiKey: "sk-direct-key-here", // This overrides everything
);

// Uses dart-define or environment variables
await promptManager.callOpenAIPrompt(
  userPrompt: "Hello",
  // No apiKey parameter - uses dart-define or env vars
);
```

## Getting API Keys

### OpenAI API Key
1. Go to [OpenAI API Keys](https://platform.openai.com/api-keys)
2. Click "Create new secret key"
3. Copy the key (starts with `sk-`)

### Anthropic Claude API Key  
1. Go to [Anthropic Console](https://console.anthropic.com/)
2. Navigate to API Keys
3. Create a new key (starts with `sk-ant-`)

## Troubleshooting

### "API key not provided" error
1. Check that `environment.json` exists and has the correct keys
2. Ensure you're running with `--dart-define-from-file=environment.json`
3. Verify the key format is correct (starts with `sk-` for OpenAI, `sk-ant-` for Claude)

### Keys not being read
1. Restart your IDE/development server
2. Clean and rebuild: `flutter clean && flutter pub get`
3. Check that the JSON format is valid

## Example Usage in Code

```dart
// In your ViewModel
void callAI() async {
  // This will automatically use keys from environment.json
  final result = await promptManager.callAIPromptForHomeView(
    userPrompt: "Make the background blue",
    currentConfig: currentState.configurable ?? HomeViewConfigurable(),
    // No need to pass apiKey - it uses dart-define values
  );
}
```