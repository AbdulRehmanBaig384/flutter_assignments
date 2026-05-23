# 📦 Product Catalog Manager

A modern and clean Flutter CRUD application built using **Provider State Management** and **HTTP API Integration**.

This application allows users to:

- View Products
- Add Products
- Edit Products
- Delete Products

using a REST API powered by `crudcrud.com`.

---

# 🚀 Features

✅ Fetch Products from API  
✅ Add New Products  
✅ Edit Existing Products  
✅ Delete Products  
✅ Provider State Management  
✅ HTTP CRUD Operations  
✅ Loading State  
✅ Empty State  
✅ Error Handling  
✅ Pull To Refresh  
✅ Responsive UI  
✅ Material 3 Design  
✅ Clean Architecture  
✅ Reusable Widgets  
✅ Beginner-Friendly & Human-Like Code  

---

# 📱 Screenshots

> Add your screenshots here

| Home Screen | Add Product | Edit Product |
|---|---|---|
| Screenshot | Screenshot | Screenshot |

---

# 🛠️ Tech Stack

| Technology | Usage |
|---|---|
| Flutter | Mobile App Development |
| Dart | Programming Language |
| Provider | State Management |
| HTTP Package | API Requests |
| crudcrud.com | REST API Backend |

---

# 📂 Folder Structure

```plaintext
lib/
├── main.dart
│
├── core/
│   ├── constants/
│   │   └── api_constants.dart
│   │
│   └── theme/
│       └── app_theme.dart
│
├── models/
│   └── product.dart
│
├── services/
│   └── product_service.dart
│
├── providers/
│   └── product_provider.dart
│
└── views/
    ├── home/
    │   ├── home_screen.dart
    │   │
    │   └── widgets/
    │       ├── product_card.dart
    │       ├── loading_state.dart
    │       └── empty_state.dart
    │
    └── product_form/
        └── product_form_screen.dart
```

---

# ⚙️ Dependencies

Add these packages inside your `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter

  provider: ^6.1.2
  http: ^1.2.1
```

Install packages:

```bash
flutter pub get
```

---

# 🌐 API Setup

This project uses:

:contentReference[oaicite:0]{index=0}

## Setup Steps

### 1. Open crudcrud.com

Generate your free private REST API endpoint.

### 2. Copy Your Unique URL

Example:

```plaintext
https://crudcrud.com/api/YOUR_UNIQUE_ID
```

### 3. Add `/products`

```plaintext
https://crudcrud.com/api/YOUR_UNIQUE_ID/products
```

### 4. Paste It Here

```plaintext
lib/core/constants/api_constants.dart
```

Example:

```dart
class ApiConstants {
  static const String baseUrl =
      'https://crudcrud.com/api/YOUR_UNIQUE_ID';

  static const String productsEndpoint =
      '$baseUrl/products';
}
```

---

# ▶️ Getting Started

## Clone Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_LINK
```

---

## Open Project

```bash
cd product_catalog_manager
```

---

## Run Application

```bash
flutter run
```

---

# 📡 CRUD Operations

| HTTP Method | Functionality |
|---|---|
| GET | Fetch Products |
| POST | Add Product |
| PUT | Update Product |
| DELETE | Delete Product |

---

# 🧠 State Management

This project uses **Provider** for state management.

### Concepts Used

- ChangeNotifier
- ChangeNotifierProvider
- Consumer
- context.read()
- context.watch()

---

# 📄 Product Model Example

```dart
class Product {
  final String? id;
  final String name;
  final double price;

  Product({
    this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
```

---

# 🎨 UI Features

- Modern Material 3 Design
- Beautiful Product Cards
- Floating Action Button
- Loading Indicators
- Empty State Screen
- Responsive Layout
- Clean Typography
- Smooth User Experience

---

# 📚 Learning Objectives

This project helped in understanding:

- Flutter State Management
- REST API Integration
- CRUD Operations
- Clean Architecture
- Async Programming
- Form Validation
- Error Handling
- Reusable Widgets
- Flutter Folder Structure

---

# 💡 Highlights

✅ Beginner-Friendly Code  
✅ Human-Like Coding Style  
✅ Clean & Readable Architecture  
✅ Industry-Level Folder Structure  
✅ Proper Separation of Concerns  
✅ Professional UI Design  

---

# ❌ Common Mistakes Avoided

- No hardcoded URLs
- No unnecessary rebuilds
- Proper Provider usage
- Proper async handling
- Proper error handling
- No unused imports
- No debug print statements

---

# 👨‍💻 Developed By

## Abdul Rehman Baig

Software Engineering Student  
University of Karachi

---

# ⭐ Support

If you like this project, give it a ⭐ on GitHub.

---

# 📜 License

This project is created for educational purposes and university assignment submission.

---
