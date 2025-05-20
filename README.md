# Arena

_Arena_ is an iOS sports app built with Swift, following the Clean Architecture design pattern and MVP structure. It leverages the [AllSportsAPI](https://allsportsapi.com/) to provide users with detailed information about sports, leagues, events, and teams. The app includes offline support for favorites and implements advanced features like onboarding, localization, and dark mode.

## 📌 Features

### 1 - Main Tabs
- **Sports Tab**  
  - Displays all sports from SportsDB API.
  - Each cell shows the sport's image and name.
  - Tapping a sport navigates to the Leagues screen.

- **Favorites Tab**  
  - Lists user's favorite leagues stored using Core Data.
  - UI mirrors the Leagues screen.
  - If online, selecting a league navigates to League Details; otherwise, an alert is shown.
 
### 2 - Leagues Screen
- Displays leagues for selected sport.
- Add or remove a league from favourites
- Tapping a league navigates to its details.

### 3 - League Events Screen
- Divided into three sections (UICollectionViewCompositionalLayout):
   1. **Upcoming Events**
     - Displays the two teams playing versus each other, date and time.
   2. **Latest Events**
     - Displays the two teams played versus each other, date, time and score.
   3. **Teams**
     - Display the teams of specific league logos.
 
### 4 - Team Details Screen
- Elegant UI showing selected team details.
  
## ✨ Additional Features
- Onboarding Screens
- Localization Support
- Dark Theme UI

## 🛠️ Testing & Architecture

- Clean Architecture
- MVP (Model-View-Presenter)
- Unit Testing using XCTest


## 📱 Tech Stack
- Swift
- Alamofire – For all API requests
- CoreData – Local persistence for favorites
- AutoLayout – For responsive UI/UX
- XCTest – Unit Testing
- Kingfisher
- Reachability
- Shimmer
- Lottie
