# OIVAN Task - StackOverflow Users App

A Flutter application that displays StackOverflow users with their reputation history, built using clean architecture principles and modern Flutter development practices.

## 🏗️ Architecture

This project follows **Clean Architecture** with **Feature-based organization**:

```
lib/
├── core/                    # Core functionality
│   ├── app_theme/          # Theme and text styles
│   ├── cache/              # Local storage service
│   ├── constants/          # App constants and dimensions
│   ├── events/             # Event bus system
│   ├── routes/             # Navigation routing
│   └── states/             # State management models
├── features/               # Feature modules
│   ├── bookmarks/          # Bookmark functionality
│   ├── home/               # Home screen with navigation
│   ├── splash/             # Splash screen
│   └── users/              # Users and reputation features
├── helper/                 # Helper utilities
├── network/                # API and network layer
├── services/               # Business logic services
└── shared/                 # Shared widgets and utilities


## 🎯 Key Features

- **StackOverflow User List**: Browse users with infinite scroll
- **Bookmark System**: Bookmark/unbookmark users with local persistence
- **Reputation History**: Detailed user reputation tracking
- **Offline Support**: Local caching with Hive
- **Modern UI**: Animated and responsive interface
- **Bottom Navigation**: Clean navigation between Users and Bookmarks

## 🛠️ Technical Stack

- **State Management**: Riverpod with StateNotifier pattern
- **Routing**: GoRouter with ShellRoute for bottom navigation
- **Local Storage**: Hive for caching and bookmarks
- **Network**: Dio for API calls
- **Animations**: flutter_animate for smooth transitions
- **UI**: Material Design with custom theming

## 📦 Helper Classes

### DateFormatter
Centralized date formatting utility for consistent date display:

```dart
// Format timestamp to readable date
DateFormatter.formatTimestamp(timestamp)

// Short date format
DateFormatter.formatShortDate(timestamp)

// Relative time (e.g., "2 hours ago")
DateFormatter.formatRelativeTime(timestamp)
```

### ReputationService
Service for handling reputation-related UI elements:

```dart
// Get appropriate icon for reputation type
ReputationService.getReputationIcon(type)

// Get color based on reputation change
ReputationService.getReputationColor(change)

// Format reputation change with signs
ReputationService.formatReputationChange(change)

// Get human-readable description
ReputationService.getReputationDescription(type)
```

## 🎨 Design System

### AppDimensions
All spacing, sizing, and layout dimensions are centralized:
- Padding: `paddingXS` to `paddingXXXL`
- Icons: `iconXS` to `iconLarge` 
- Border Radius: `radiusXS` to `radiusFull`
- Avatar Sizes: `avatarSizeXS` to `avatarSizeXXL`
- Responsive Breakpoints: Mobile, tablet, desktop

### AppTextTheme
Comprehensive text styling system:
- Standard Material styles: `displayLarge`, `titleMedium`, etc.
- Custom app styles: `appBarTitle`, `userCardTitle`, etc.
- No `copyWith` usage - all styles pre-defined

### AppColors
Consistent color palette throughout the app:
- Primary brand colors
- Text colors with hierarchy
- Status colors (success, error, info)
- Theme variations

## 🏛️ State Management

Using **Riverpod** with **StateNotifier** pattern:



## 🌐 API Integration

**StackExchange API v2.2** integration:
- Users endpoint: `/users`
- Reputation history: `/users/{id}/reputation-history`
- Pagination support with `page` and `pagesize`
- Error handling with custom interceptors

## 💾 Local Storage

**Hive-based caching system**:
- Generic `ILocalCacheService` interface
- Bookmark persistence
- User data caching
- Type-safe storage operations

## 🎭 UI Components

### Shared Widgets
- `EmptyStateWidget`: Consistent empty states
- `ErrorStateWidget`: Standardized error display  
- `LoadingWidget`: Animated loading indicators


## 🔄 Navigation

**GoRouter with ShellRoute**:
- Bottom navigation persistence
- Route-based state management
- Nested navigation for details

## 📱 Responsive Design

- **ScreenUtil** for responsive sizing
- **AppDimensions** for consistent spacing
- **Breakpoint-aware** layout decisions
- **Device-specific** optimizations

## 🚀 Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   

2. **Generate code**:
   ```bash
   flutter pub run build_runner build
   

3. **Run the app**:
   ```bash
   flutter run
 
 

## 📊 Performance Optimizations

- **Const constructors** wherever possible
- **Widget rebuilding** minimization with Riverpod
- **Lazy loading** with pagination
- **Image caching** for user avatars
- **Local data persistence** for offline support

## 🚀 CI/CD Pipeline

This project includes a comprehensive **GitHub Actions** CI/CD pipeline that automates testing, building, and deployment processes.

### Pipeline Overview

The CI/CD pipeline is triggered on:
- **Push** to `main` and `develop` branches
- **Pull requests** to `main` branch


### Configuration

The pipeline configuration is located in `.github/workflows/ci_cd.yml` and can be customized for:
- Different Flutter versions
- Additional testing frameworks
- Custom deployment targets
- Environment-specific configurations

