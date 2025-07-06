# Life Simulation Game 🎮

A comprehensive Flutter-based life simulation game built with modern architecture principles and best practices.

## 🚀 Features

- **Complete Life Simulation**: Create and manage virtual characters through their entire life journey
- **Real-time Character Development**: Watch your character grow, learn, and evolve over time
- **Career Progression**: Choose from various career paths and advance through different life stages
- **Social Interactions**: Build relationships, get married, and start families
- **Achievement System**: Unlock achievements and track your progress
- **Statistics Dashboard**: Monitor health, happiness, wealth, and other important metrics

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **Feature-Based Organization**:

### Technical Stack
- **Flutter**: UI framework for cross-platform development
- **Firebase**: Backend services (Authentication, Firestore, Storage)
- **Riverpod**: State management and dependency injection
- **GoRouter**: Navigation and routing
- **Freezed**: Immutable data classes and unions
- **Injectable**: Dependency injection

### Architecture Layers
```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants
│   ├── errors/             # Error handling
│   ├── injection/          # Dependency injection
│   ├── router/             # Navigation configuration
│   ├── theme/              # UI theming
│   └── utils/              # Utility functions
├── features/               # Feature modules
│   ├── authentication/     # User authentication
│   ├── character/          # Character management
│   ├── game_mechanics/     # Core game logic
│   ├── life_events/        # Life events and decisions
│   └── statistics/         # Statistics and analytics
└── shared/                 # Shared components
    ├── models/             # Common data models
    ├── services/           # Shared services
    └── widgets/            # Reusable UI components
```

Each feature follows **Clean Architecture** with three layers:
- **Domain**: Business logic, entities, and use cases
- **Data**: Data sources, repositories, and models
- **Presentation**: UI, widgets, and state management

## 🛠️ Development Principles

### SOLID Principles
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Derived classes must be substitutable for base classes
- **Interface Segregation**: Clients should not depend on interfaces they don't use
- **Dependency Inversion**: Depend on abstractions, not concretions

### Clean Code Practices
- **DRY** (Don't Repeat Yourself): Avoid code duplication
- **YAGNI** (You Aren't Gonna Need It): Don't add unnecessary features
- **Meaningful Names**: Use descriptive names for variables, functions, and classes
- **Small Functions**: Keep functions small and focused
- **Comments**: Code should be self-documenting

### Testing Strategy
- **TDD** (Test-Driven Development): Write tests before implementation
- **Unit Tests**: Test individual components in isolation
- **Integration Tests**: Test feature interactions
- **Widget Tests**: Test UI components
- **End-to-End Tests**: Test complete user workflows

## 🎯 Game Mechanics

### Character Creation
- Choose name, gender, and birth date
- Select starting career path
- Customize appearance and personality traits

### Life Progression
- **Daily Activities**: Work, study, exercise, socialize
- **Life Events**: Birthday celebrations, graduations, career changes
- **Relationships**: Meet people, date, get married, have children
- **Health & Wellness**: Manage physical and mental health
- **Financial Management**: Earn money, make investments, purchase items

### Statistics System
- **Health**: Physical and mental well-being
- **Happiness**: Life satisfaction and mood
- **Intelligence**: Knowledge and learning capacity
- **Fitness**: Physical strength and endurance
- **Creativity**: Artistic and innovative abilities
- **Social Skills**: Relationship and communication abilities

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>= 3.10.0)
- Dart SDK (>= 3.0.0)
- Firebase project setup
- Android Studio / VS Code

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/eneserdemirci/eneserdemirci.git
   cd eneserdemirci/life_simulation_game
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate code:
   ```bash
   flutter packages pub run build_runner build
   ```

4. Configure Firebase:
   - Create a Firebase project
   - Add your Firebase configuration files
   - Update `lib/firebase_options.dart` with your project details

5. Run the app:
   ```bash
   flutter run
   ```

### Development Setup
1. Run code generation in watch mode:
   ```bash
   flutter packages pub run build_runner watch
   ```

2. Run tests:
   ```bash
   flutter test
   ```

3. Run integration tests:
   ```bash
   flutter drive --target=test_driver/app.dart
   ```

## 🧪 Testing

### Unit Tests
Test individual components:
```bash
flutter test test/unit/
```

### Widget Tests
Test UI components:
```bash
flutter test test/widget/
```

### Integration Tests
Test feature interactions:
```bash
flutter test test/integration/
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful commit messages
- Add tests for new features
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Enes Erdemirci**
- GitHub: [@eneserdemirci](https://github.com/eneserdemirci)
- Email: [contact@eneserdemirci.com](mailto:contact@eneserdemirci.com)

## 🎉 Acknowledgments

- Flutter team for the amazing framework
- Firebase team for excellent backend services
- Open source community for invaluable packages and tools

---

*Built with ❤️ using Flutter and clean architecture principles*