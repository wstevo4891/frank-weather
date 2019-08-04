
# Frank Weather

The app where Frank tells you the weather...frankly.

This is a simple Sinatra app that retrieves weather data from the OpenWeatherMap API.

## Getting Started

1. Sign up with OpenWeatherMap [here](https://home.openweathermap.org/users/sign_up)

2. Get an API key [here](https://home.openweathermap.org/api_keys)

3. Git clone frank-weather

4. Make an env.rb file at the root directory

5. Define your API key in env.rb like so:

   ```ruby
   ENV['API_KEY] = 'your-api-key'
   ```

6. Start the server

   cd frank-weather
   ruby frank_weather.rb

   The app uses 'sinatra/reloader' so any changes to the files will
   not require a server restart.

## Using the App

Type a city name and country ISO code in the form to get searching.

Make sure to use the two-character ISO codes for countries.
Examples:
  United Kingdom: UK
  United States: US
  France: FR
  Spain: ES
  China: CN

There are currently two urls for querying weather data:

/weather/:city/:country

/weather-data/:city/:country

The first route displays an HTML view of the data

The 'weather-data' route displays a pretty-printed JSON response

Examples:

localhost:3000/weather/London/uk

localhost:3000/weather-data/London/uk

Enjoy!
