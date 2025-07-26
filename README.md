# AI Prompt-Driven Flutter App

A revolutionary Flutter application that demonstrates dynamic UI configuration through AI prompts. This app showcases how artificial intelligence can be used to modify user interfaces in real-time, creating personalized and adaptive user experiences through both predefined prompts and custom AI interactions.

## 🌟 Features

### Dynamic UI Configuration
- **Real-time UI Updates**: Modify app appearance and behavior through natural language prompts
- **AI-Powered Customization**: Use both predefined prompts and custom AI requests to change colors, layouts, content, and functionality
- **Live Preview**: See changes instantly without app restarts or recompilation

### Comprehensive Widget System
- **Dynamic Scaffolds**: Configurable backgrounds, layouts, and structural elements
- **Smart Navigation Bars**: Adaptive app bars with customizable titles and styling
- **Interactive Cards**: Dynamic greeting cards, stat cards, and information displays
- **Flexible Grids**: Configurable quick action grids with customizable layouts
- **Profile Components**: Dynamic user profiles with configurable avatars and information
- **Settings Sections**: Adaptive settings with toggles, navigation, and custom options

### Multi-View Architecture
- **Home View**: Dashboard-style interface with stats, greetings, and quick actions
- **Profile View**: User profile management with stats, settings, and personalization
- **Seamless Navigation**: Smooth transitions between views with consistent theming

## 🏗️ Architecture

### Core Components

#### Configuration System
```
lib/src/config/
├── appbar_config.dart          # Navigation bar configurations
├── greeting_card_config.dart   # Greeting card customization
├── profile_header_config.dart  # Profile header settings
├── quick_action_config.dart    # Quick action grid layouts
├── scaffold_config.dart        # App structure configuration
├── settings_section_config.dart # Settings panel customization
├── stat_card_config.dart       # Statistical card displays
└── stats_section_config.dart   # Stats section configuration
```

#### Dynamic Widgets
```
lib/src/dynamic_widgets/
├── dynamic_scaffold.dart                    # Configurable app structure
├── dynamic_cupertino_sliver_navigation_bar.dart # Adaptive navigation
├── dynamic_greeting_card.dart               # Personalized greetings
├── dynamic_stat_card.dart                   # Statistical displays
├── dynamic_stats_section.dart               # Stats overview section
├── dynamic_profile_header.dart              # User profile headers
├── dynamic_quick_action_grid.dart           # Action button grids
└── dynamic_settings_section.dart           # Settings panels
```

#### AI Prompt Management
```
lib/src/model/
├── prompt.dart              # Prompt definitions and configurations
├── view_configurable.dart   # View configuration interfaces
└── setting_model.dart       # Settings data models

lib/src/utils/
├── prompt_manager.dart      # AI prompt processing
└── widget_parser.dart       # Configuration parsing utilities
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS/Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   # Replace with your actual repository URL
   git clone [your-repository-url]
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
   flutter run
   ```

## 🎯 Usage

### Using AI Prompts

The app supports two types of prompts:

1. **Predefined Prompts**: Quick-access buttons for common UI modifications
2. **Custom AI Prompts**: Natural language requests processed by AI to generate UI changes

#### Predefined Prompts

The app includes several predefined prompts that demonstrate the dynamic configuration capabilities:

#### Home View Prompts
- **"Make background blue"** - Changes the app background to blue
- **"Change the app bar title to Dashboard"** - Updates navigation title
- **"Change first stat card to Revenue"** - Modifies stat card content and styling
- **"Make greeting cards sunset themed"** - Apply sunset gradient colors
- **"Add productivity quick actions"** - Configure productivity-focused action buttons

#### Profile View Prompts
- **"Add notification settings"** - Adds toggle-based notification preferences
- **"Customize profile header with star avatar"** - Changes avatar to star icon with custom styling
- **"Hide email and make compact profile"** - Creates a minimal profile layout
- **"Use network image for avatar"** - Loads avatar from network URL
- **"Update stats to show productivity metrics"** - Configures stats for productivity tracking

### Accessing Prompts

1. **Tap the floating action button** (FAB) in any view
2. **Choose your interaction method**:
   - **Select from predefined prompts** for quick common changes
   - **Enter custom AI prompt** in the text field for natural language requests
3. **Watch the UI update** in real-time
4. **Reset to default** using the reset option

#### Custom AI Prompt Examples
- "Make the background a warm sunset color"
- "Change the greeting card to show welcome message with blue theme"
- "Update the first stat card to show sales data with green colors"
- "Make the quick actions grid show communication tools"
- "Change the profile avatar to use a heart icon and make it purple"

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

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

Run widget tests:
```bash
flutter test test/widget_test.dart
```

## 📱 Platform Support

- ✅ **iOS** - Full support with Cupertino design
- ✅ **Android** - Material Design integration
- ✅ **Web** - Responsive web experience
- ✅ **macOS** - Native desktop experience
- ✅ **Windows** - Cross-platform desktop support
- ✅ **Linux** - Linux desktop compatibility

## 🛠️ Dependencies

### Core Dependencies
- **flutter**: SDK framework
- **cupertino_icons**: iOS-style icons
- **equatable**: Value equality comparisons
- **http**: HTTP client for AI API requests
- **intl**: Internationalization support

### AI Integration
- **OpenAI API**: GPT-4o-mini model for natural language UI modifications
- **Anthropic API**: Claude-3-haiku model as alternative AI provider

### API Requirements
To use the AI functionality, you need at least one of the following:
- OpenAI API key (set `OPENAI_API_KEY` in environment.json)
- Anthropic API key (set `ANTHROPIC_API_KEY` in environment.json)

**Cost Considerations**: Each AI prompt makes API calls that incur costs. Both providers offer free tiers for development.

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Code quality rules

## 🏛️ Architecture Patterns

### MVVM Pattern
- **Models**: Data and business logic
- **Views**: UI components and screens
- **ViewModels**: State management and view logic

### Configuration-Driven UI
- **Separation of Concerns**: UI logic separated from configuration
- **Dynamic Updates**: Runtime configuration changes
- **Type Safety**: Strongly typed configuration objects

### Factory Pattern
- **ViewConfigurable Factory**: Creates appropriate view configurations
- **Widget Parser**: Converts string configurations to Flutter objects

## 🔒 Security

### API Key Security
- **Never commit API keys**: The `environment.json` file is gitignored for security
- **Use environment variables**: For production deployments, use secure environment variable management
- **Rotate keys regularly**: Regularly rotate your API keys for security
- **Monitor usage**: Keep track of API usage to detect unauthorized access

### Best Practices
- Always use the example files as templates (never put real keys in `.example` files)
- Use different keys for development and production environments
- Implement rate limiting in production applications
- Consider using API key management services for production deployments

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter/Dart style guidelines
- Use StatelessWidgets instead of functions returning Widgets
- Utilize spacing arguments in flex widgets instead of SizedBoxes
- Maintain consistent naming conventions
- Add comprehensive documentation for new features

## 📄 License

This project is available for use and modification. Add a license file if you plan to distribute this project.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- AI/ML community for inspiration on dynamic UI concepts
- Contributors and testers who helped shape this project

## 📞 Support

For questions, issues, or contributions:
- Create an issue on the repository
- Check existing documentation
- Review the codebase for implementation examples

---

**Built with ❤️ using Flutter**