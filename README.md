# RickMortyApp

SwiftUI-based iOS app featuring Clean Architecture, infinite scrolling, image caching, and unit testing.

## Entities

- Character
    id
    gender
    imageURL
    name
    status

## Use Cases

### Show a list of characters

**As a user, I want to see a list of characters with infinite scrolling.**

- **Given**: I have launched the app.  
- **When**: I am on the list view.  
- **Then**: I see the list of characters, loaded infinitely as I scroll.  
- **And**:
  - Character image (loaded asynchronously)  
  - Character name  
  - Status indicator (using a colored dot)  
  - Gender icon (using SF Symbols)  

## List Component Selection

I have chosen `List` because it is the standard list component in SwiftUI. If greater customization is required, one could use `ScrollView` with `LazyVStack`.

### Performance Impact

- `LazyVStack` retains all loaded elements in memory, which can lead to increased memory usage as more items are displayed.  
- In contrast, `List` efficiently reuses its cells (view reuse), improving performance and reducing resource consumption.  
