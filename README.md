# News App

## 1. Project Overview
This project is a News App built using Flutter. The app fetches real-time news articles from NewsAPI and displays them in a user-friendly interface. It includes features like state management, error handling, and offline support using cached data.

## 2. Features Implemented

  Fetching Data from API
   - Integrated NewsAPI to fetch articles.
   - Displays the following information:
     - Title
     - Description
     - Thumbnail Image
     - Published Date

  UI Design
    - Created a responsive and clean UI using GridView.builder.
    - Each news item includes:
      - Thumbnail image
      - Bold title
      - Short description
      - Published date in a smaller font
      
   State Management
    - Implemented Provider for efficient state management.
    - Handles different states:
      - Loading state (displays a progress indicator)
      - Successful data fetch (displays articles)
      - Error state (shows a message and retry option)

   Error Handling
    - Displays a user-friendly error message when:
      - There is no internet connection.
      - API request fails.
    - Added a Retry button to reload data when an error occurs.

   Local Storage (Bonus Feature)
    - Implemented caching using Hive to store articles for offline access.
    - If there is no internet connection, saved articles are displayed instead of an error message.

## 3. Technologies Used
  - Flutter (UI Framework)
  - Dart (Programming Language)
  - Provider (State Management)
  - HTTP (API Requests)
  - Hive (Local Storage for offline support)

## 4. Packages Used
  - http
  - provider
  - internet_connection_checker_plus
  - hive_ce
  - hive_ce_flutter
  - path_provider
    
## 5. Folder Structure
|-- lib/
    |-- main.dart           # Entry point of the app
    |-- screens/
        |-- home_screen.dart   # Displays list of news articles
        |-- details_screen.dart # Displays detailed news article
    |-- models/
        |-- news_model.dart    # Data model for news articles
    |-- providers/
        |-- news_provider.dart # Handles state management
    |-- services/
        |-- api_service.dart   # Fetches news from API


