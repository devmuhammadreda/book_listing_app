# 📚 Flutter Technical Task – Nagwa

This is a simple **Book Listing App** built with **Flutter** using the [Gutendex API](https://gutendex.com/). It allows users to browse and search books from Project Gutenberg. The app features infinite scrolling, search functionality, persistent caching, and follows Clean Architecture with Bloc (Cubit) for state management.

---

## 🚀 Features

### 📖 Book List Screen
- Fetches and displays books on launch.
- Implements **infinite scrolling** with auto-fetching on scroll.
- Each item includes:
  - **Cover Image**
  - **Title**
  - **Author(s)**
  - **Collapsible Summary** with **See More/See Less** toggle.

### 🔍 Search Functionality
- Prominent **search bar**.
- Queries books using `?search=` endpoint.
- Supports **infinite scrolling** on search results too.

### 🔄 Pull-to-Refresh
- Pull down on the list to refresh the current content.

### 📦 Offline Caching 
- If implemented: cached content loads when offline or API fails.

---

## 🧰 Technical Stack

- **Flutter** (stable)
- **Cubit** from flutter_bloc (for state management)
- **dio** for API calls
- **Hive** for offline caching
- **Clean Architecture** principles
- Fully responsive layout

---

## 🌐 API Reference

### Base URL
```
https://gutendex.com
```

### Get all books
```http
GET /books
```

### Search books
```http
GET /books?search=harry
```
---

## 📹 Demo (Video)
🎥 [Watch Demo](https://drive.google.com/file/d/1tBSOd83_5yO7gAW3Rh0Pv4TtoB0FMu1E/view?usp=drive_link)

---

## 📦 Demo (APK)
📱 [Download APK](https://drive.google.com/file/d/1jOOqk8d0rA6Fb1Xd6JwsIs1x7gbE8nSb/view?usp=drive_link)

---

## 🛠 How to Run

1. Clone this repo:
   ```bash
   git clone https://github.com/devmuhammadreda/book_listing_app
   cd flutter_book_listing_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## ✨ Notes

- Summary expands/collapses using a toggleable widget.
- Pagination logic is managed via Cubit and lazy-loading via scroll listener.
- Error states and loading indicators are handled per screen.
- Clean separation between UI, logic, and data.

---

## ✅ Evaluation Criteria Addressed

- ✅ Functional completeness
- ✅ Clean Architecture + Bloc/Cubit
- ✅ API integration & pagination
- ✅ Responsive UI/UX
- ✅ Error handling
- ✅ Offline Caching

---

## 📧 Submission

- GitHub repo: https://github.com/devmuhammadreda/book_listing_app
- devmuhammadreda@gmail.com
