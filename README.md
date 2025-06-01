# RickMortyApp

A SwiftUI-based iOS app that displays a list of characters from the Rick and Morty universe, following Clean Architecture principles.

## 📱 Features

- Character list with:
  - Name
  - Status indicator (colored dot)
  - Gender symbol (represented using **Unicode characters**, since SF Symbols were not visually suitable)
  - Asynchronous image loading and caching (via [Kingfisher](https://github.com/onevcat/Kingfisher))
- Loading and error states
- Clean, modular and scalable architecture

## 🧱 Architecture

The app follows **Clean Architecture** principles and uses **MVVM** in the Presentation layer:

- **Presentation**: SwiftUI Views + ViewModels
- **Domain**: Use Cases, Entities and Interfaces
- **Data**: Repositories and Mappers
- **Infrastructure**: Networking with `URLSession`
- **Composition**: Responsible for assembling dependencies

## 🛠 Technical Decisions

- **SwiftUI `List`** was chosen over `ScrollView + LazyVStack` for better performance and built-in view recycling.
- **Kingfisher** is used to improve performance by caching downloaded images.
- **Unicode characters** were used for gender icons, as they provided a more intuitive visual representation than SF Symbols in this case.
- While pagination and search were considered, this version only implements basic character listing to keep the focus on architecture and maintainability.

## 🔧 Dependencies(SPM)

- [`Kingfisher`](https://github.com/onevcat/Kingfisher) – For efficient image downloading and caching.

## 📄 API

Data is fetched from the [Rick and Morty API](https://rickandmortyapi.com/api/character), which provides character metadata in a RESTful format.

## 🚀 Requirements

- **iOS 17 or later**
- Developed using **Xcode 16.2**

## 🧭 Assumptions

- **Pagination and filtering** were not explicitly required to be implemented at this stage, but were considered in the architectural design for future scalability.
- **SF Symbols** were avoided for gender representation because they did not visually express the concept clearly enough. Unicode characters were used instead for better clarity.
- **Character listing only** was implemented to focus on clean architecture and maintainability, prioritizing a solid and extensible foundation.

---

Developed by **Guido Fabio**
