# AI Prompt-Driven Flutter App

https://github.com/user-attachments/assets/e5d5412d-749d-4819-aca4-92dfa6a34fe1

## 🚀 Getting Started

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/demolaf/ai_prompt_driven_app
   cd ai_prompt_driven_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up API keys for AI functionality**
   ```bash
   cp environment.example.json environment.json
   # Edit environment.json with your API keys:
   # - OPENAI_API_KEY: Your OpenAI API key (for GPT-4)
   # - ANTHROPIC_API_KEY: Your Anthropic API key (for Claude)
   ```

   **⚠️ Security Warning**:
   - Never commit `environment.json` to version control (it's in .gitignore)
   - Never share your actual API keys publicly
   - API keys should only contain placeholder text in documentation

   **Note**: At least one API key is required for AI prompt functionality. Without API keys, only predefined prompts will work.

4. **Run the application**
   ```bash
   flutter run --dart-define-from-file environment.json
   ```

## 🎯 Usage

### Using AI Prompts

The app supports two types of prompts:

1. **Predefined Prompts**: Quick-access buttons for common UI modifications
2. **Custom AI Prompts**: Natural language requests processed by AI to generate UI changes

#### Predefined Prompts

The app includes several predefined prompts that demonstrate the dynamic configuration capabilities:

### Accessing Prompts

1. **Tap the floating action button** (FAB) in any view
2. **Choose your interaction method**:
   - **Select from predefined prompts** for quick common changes
   - **Enter custom AI prompt** in the text field for natural language requests
3. **Watch the UI update** in real-time
4. **Reset to default** using the reset option

## 🎨 Customization

### Creating Custom Prompts

Add new prompts to `lib/src/model/prompt.dart`:

```dart
{
  'id': 'custom_001',
  'title': 'Your Custom Prompt Title',
  'configurable': {
    'type': 'home', // or 'profile'
    'scaffoldConfig': {
      'backgroundColor': 'FFFF5722', // Orange background
    },
    'appBarConfig': {
      'title': 'Custom Title',
    },
  },
}
```

### Adding New Configurations

1. **Create a config class** in `lib/src/config/`
2. **Implement required methods**: `toJson()`, `fromJson()`, `copyWith()`, `schema`
3. **Add to view configurables** in the appropriate view configuration file
4. **Update the ViewConfigurable factory** in `lib/src/model/view_configurable.dart`

### Creating Dynamic Widgets

Follow the established pattern:
```dart
class DynamicCustomWidget extends StatelessWidget {
  const DynamicCustomWidget({this.config, super.key});
  
  final CustomWidgetConfig? config;
  
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: config?.visible ?? true, 
      child: _buildWidget()
    );
  }
  
  Widget _buildWidget() {
    // Implementation with fallback for null config
  }
}
```

## 🏛️ Architecture Patterns

### MVVM Pattern
- **Models**: Data and business logic
- **Views**: UI components and screens
- **ViewModels**: State management and view logic

### Configuration-Driven UI
- **Separation of Concerns**: UI logic separated from configuration
- **Dynamic Updates**: Runtime configuration changes
- **Type Safety**: Strongly typed configuration objects

---
