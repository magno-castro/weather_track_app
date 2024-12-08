### README

# Tour Weather Tracker 🌦️

An application built for Android and iOS to track the weather for a rock'n'roll band's tour. This app provides the current weather and a 5-day forecast for the main cities where the band's concerts will take place. 

---

## Features ✨

- **Current Weather**: Displays the current weather for each city.
- **5-Day Forecast**: Provides a detailed weather forecast for the next 5 days.
- **Search**: Easily search for a city in the tour list using a search bar.
- **Offline Mode**: The app works seamlessly offline by caching data locally.
- **Responsive Design**: Supports multiple resolutions and screen sizes.

---

## Cities Included 🌍

- **Silverstone, UK**  
- **São Paulo, Brazil**  
- **Melbourne, Australia**  
- **Monte Carlo, Monaco**  

---

## Getting Started 🚀

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- API key for OpenWeather. You can get one [here](https://home.openweathermap.org/api_keys).

### Installation

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set up the OpenWeather API key**:
   - Create a file called `.env` in the root directory.
   - Add the following line:
     ```env
     API_KEY=your_api_key_here
     ```

4. **Run the app**:
   ```bash
   flutter run --dart-define-from-file=.env
   ```

---

## APIs Used 🌐

- **Current Weather**: [OpenWeather Current API](https://openweathermap.org/current)  
- **5-Day Forecast**: [OpenWeather Forecast API](https://openweathermap.org/forecast)

---

## Offline Support 📡

The app caches weather data locally to ensure it works even without an internet connection (e.g., in airplane mode). When offline, it loads the most recent data available.

---

## How to Contribute 🤝

1. **Fork the repository**  
2. **Create a branch** for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. **Commit your changes**:
   ```bash
   git commit -m "Description of changes"
   ```
4. **Push to the branch**:
   ```bash
   git push origin feature-name
   ```
5. **Open a Pull Request**.

---

## License 📜

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to suggest any improvements or report issues! 🚀