# Bookstore App

A Flutter-based online bookstore application built as a final team project.
Demonstrates Clean Architecture, state management, local/cloud persistence, and complex UI layouts.

##  Team

| Member | Role |
|--------|------|
| Ayazhan | Backend & Data Layer |
| Nazym | UI & Navigation Layer |

---

##  Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code
- Firebase project with Android app configured

### Setup

1. **Clone the repository**
```bash
   git clone <your-repo-url>
   cd my_bookstore
```

2. **Install dependencies**
```bash
   flutter pub get
```

3. **Generate code** (Drift + Riverpod + Freezed)
```bash
   dart run build_runner build --delete-conflicting-outputs
```

4. **Firebase setup**
   - Place your `google-services.json` in `android/app/`
   - Firebase Authentication must have Email/Password enabled
   - Firestore must be active in your Firebase project

5. **Run the app**
```bash
   flutter run
```

---

## Architecture

Clean Architecture with 3 layers:

```
lib/
├── core/
│   ├── network/          # Chopper client & API service
│   ├── providers/        # Theme provider (Shared Preferences)
│   └── router.dart       # go_router config + auth guard
├── features/
│   ├── auth/             # Login, Register screens
│   ├── catalog/          # Book listing, Book detail
│   ├── cart/             # Shopping cart (Riverpod)
│   ├── wishlist/         # Wishlist (Drift/SQLite)
│   ├── orders/           # Order history (Firestore)
│   ├── profile/          # Profile, settings, dark mode
│   └── currency/         # Currency converter (Networking)
```

---

## Features

### Authentication
- Email/Password login and registration via Firebase Auth
- Auth state redirect guard — unauthenticated users always land on login
- Form validation with friendly error messages

### Catalog
- Books fetched from **Google Books API** via Chopper
- Genre filtering and search
- `SliverAppBar` + `GridView` layout
- Fallback to local mock data if API is unavailable

### Book Detail
- Full cover, title, author, rating, genre, description
- Add to cart button
- Heart button to toggle wishlist (persisted to SQLite)

### Cart
- Add/remove books
- Total price calculation
- Managed with Riverpod state

### Wishlist
- Persisted locally using **Drift (SQLite)**
- Survives app restarts
- Displayed on profile screen, removable

### Profile
- Displays signed-in user info
- **Currency converter** (USD → EUR, GBP, KZT, RUB) via external API
- **Dark mode toggle** saved to **Shared Preferences**
- Sign out

### Orders
- Order history from **Firestore** with realtime status updates

---

## Tech Stack

| Technology | Usage |
|------------|-------|
| Flutter + Dart | UI framework |
| Riverpod | State management & DI |
| go_router | Declarative navigation |
| Chopper + http | API networking |
| Drift (SQLite) | Local wishlist persistence |
| Shared Preferences | Theme setting persistence |
| Firebase Auth | User authentication |
| Cloud Firestore | Order history (realtime) |
| Google Books API | Book data |

---


- Run `build_runner` after any changes to Drift table or Riverpod generator files
- Dark mode toggle is in Profile → Settings
- App falls back to mock book data if Google Books API quota is exceeded
