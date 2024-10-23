import QtQuick
import ModelViewDelegate

ListModel {
    id: weatherModel

    property string weatherRequest: ""
    property bool fahrenheit: false

    onWeatherRequestChanged: update()
    onFahrenheitChanged: update()

    /* weather request API response example */
    readonly property var weatherResponseExample: {
        "current_units": {
            "temperature_2m": "°C",
        },
        "current": {
            "time": "2024-06-10T12:15",
            "temperature_2m": 21.0,
            "weather_code": 1
        },
        "daily": {
            "time": [
                "2024-06-10",
                "2024-06-11",
                "2024-06-12",
                "2024-06-13",
                "2024-06-14",
                "2024-06-15",
                "2024-06-16"
            ],
            "weather_code": [
                3,
                1,
                1,
                0,
                3,
                3,
                0
            ],
            "temperature_2m_max": [
                22.0,
                21.7,
                23.3,
                20.5,
                22.3,
                21.5,
                20.0
            ],
            "temperature_2m_min": [
                12.0,
                8.0,
                10.4,
                8.6,
                6.9,
                8.9,
                9.0
            ]
        }
    }

    readonly property bool valid: time.length && count > 0

    property string time
    property real temp: 0
    property string units: "ºC"
    property int weather_code: 0 // sunny by default

    property bool busy: false

    function update() : void {

        if(weatherRequest.length === 0) {
            return
        }

        busy = true

        let weatherRequestUrl = Qt.url(fahrenheit ? weatherRequest + "&temperature_unit=fahrenheit" : weatherRequest)

        Requester.sendRequest(weatherRequestUrl, function(response) {

            clear()

            let weatherResponseData = JSON.parse(response.content)

            if(weatherResponseData === undefined) {
                console.log("Could not get weather data", weatherRequestUrl)
                busy = false
                return
            }

            // current weather units
            units = weatherResponseData["current_units"]["temperature_2m"]

            // current weather
            let current = weatherResponseData["current"]

            time = current["time"]
            temp = current["temperature_2m"]
            weather_code = current["weather_code"]

            console.log("Today")
            console.log(time,
                        temp,
                        units,
                        weather_code)


            // daily weather for next 7 days
            let daily = weatherResponseData["daily"]
            let daily_time = daily["time"]
            let daily_weather_code = daily["weather_code"]
            let daily_temp_max = daily["temperature_2m_max"]
            let daily_temp_min = daily["temperature_2m_min"]

            console.log(`Next ${daily_time.length} Days`)

            // loop through the data and append to the ListModel with a JSON object containing the role values
            // the weatherModel for the 7 days (daily_time.length)

            for(let day = 0; day < daily_time.length; day++) {

                append({
                           "time": daily_time[day],
                           "weather_code": daily_weather_code[day],
                           "temp_max": daily_temp_max[day],
                           "temp_min": daily_temp_min[day],
                           "units": weatherModel.units // compatibility with StaticWeatherModel
                       })

                console.log(day,
                            daily_time[day],
                            daily_weather_code[day],
                            daily_temp_max[day],
                            daily_temp_min[day],
                            units)
            }

            busy = false
        })
    }
}
