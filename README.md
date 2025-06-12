## RickMortyApp

A SwiftUI-based iOS app that displays and manages characters from the Rick and Morty universe, following Clean Architecture principles.

---

## 📱 Features

- **List**: Display a paginated list of characters with:
  - Name
  - Status indicator (colored dot)
  - Gender symbol (using Unicode characters)
  - Asynchronous image loading and caching via [Kingfisher](https://github.com/onevcat/Kingfisher)
- **Search**: Find characters by name using a live search bar
- **Filter**: Filter characters by status (Alive, Dead, Unknown) and gender (Male, Female, Genderless, Unknown)
- **Cache**: Efficiently cache both API responses and images for offline support and faster loads
- **Favorites**: Mark characters as favorites and view them in a dedicated Favorites tab. This feature will be refactored to better adhere to Clean Architecture principles and should include additional unit and UI tests for comprehensive coverage
- Graceful loading and error states throughout the app

---

## 🧱 Architecture

The app follows **Clean Architecture** and applies **MVVM** in the Presentation layer:

- **Presentation**: SwiftUI Views + ViewModels
- **Domain**: Use Cases, Entities and Interfaces
- **Data**: Repositories and Mappers
- **Infrastructure**: Networking with `URLSession`
- **Composition**: Assembling and injecting dependencies

---

## 🚀 Requirements

- **iOS 17 or later**
- **Xcode 16.2**
- **Swift 5.7+**

---

## 🛠 Technical Decisions

- **SwiftUI `List`** for built-in view recycling and smooth scrolling
- **Kingfisher** for efficient image downloading and caching
- **Unicode characters** for gender icons to ensure clarity over SF Symbols
- **Pagination, search, filter, caching, and favorites** built into the core architecture for easy extension

---

## 📄 API

Data is fetched from the [Rick and Morty API](https://rickandmortyapi.com/api/character) in a RESTful format.

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

---

_Developed by **Guido Fabio**_

