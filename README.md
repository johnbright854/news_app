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
    

# How i approached the task?

1. Understanding the Requirements
  - I carefully reviewed the task description and the expected functionality.
  - Identified the key features needed for the app (e.g., fetching news from an API, displaying articles, handling offline storage).

2. Tech Stack Selection
  - Used Flutter for the frontend to ensure a smooth and responsive UI.
  - Integrated Hive for local caching to improve performance and offline access.
  - Utilized Provider for state management to handle API responses and data updates efficiently.
  - Used http package to make network requests to fetch news articles.

3. Implementing the Core Features
  - Fetched news articles from the NewsAPI dynamically.
  - Implemented pagination to load more news as the user scrolls.
  - Implemented offline support by caching data with Hive.
  - Integrated InternetConnectionCheckerPlus to monitor network status and decide whether to use cached data or fetch from the API.

4. Error Handling and Optimization
  - Handled API errors (e.g., no internet, server issues) with appropriate UI feedback.
  - Used efficient state management to minimize unnecessary re-renders and improve app performance.

5. Testing and Debugging
  - Tested the app on different devices and emulators to ensure UI consistency.
  - Debugged any issues related to API integration and caching mechanisms.

6. Finalizing and Submitting the Task
  - Wrote clean and maintainable code following Flutter best practices.
  - Created a README with setup instructions, dependencies, and explanation of the approach.
  - Pushed the code to GitHub and verified everything was working as expected.


