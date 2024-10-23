import QtQuick
import ModelViewDelegate

ListModel {
    id: locationModel

    /* location request API response example */
    // Note: admin1 and country fields could be "undefined"
    readonly property var locationResponseExample: {
        "results": [
                    {
                        "name": "Brisbane",
                        "admin1": "Queensland",
                        "country": "Australia",
                        "latitude": -27.46794,
                        "longitude": 153.02809,
                        "timezone": "Australia/Brisbane"
                        //... plus other keys we don't need
                    },
                    //...
                ]
    }

    property bool busy: false
    signal updated

    function update(location: string): void {

        if(location.length === 0) {
            return
        }

        busy = true

        let locationRequest = Qt.url(`https://geocoding-api.open-meteo.com/v1/search?name=${location}&count=10&language=en&format=json`)

        Requester.sendRequest(locationRequest, function(response) {

            clear()

            let locationResponseData = JSON.parse(response.content)["results"]

            if(locationResponseData === undefined) {
                console.log("Could not get location", locationRequest)
                busy = false
                return
            }

            for(let locationIndex = 0; locationIndex < locationResponseData.length; locationIndex++) {

                let location = locationResponseData[locationIndex]

                let name = location["name"]
                let admin1 = location["admin1"]
                let country = location["country"]
                let latitude = location["latitude"]
                let longitude = location["longitude"]
                let timezone = location["timezone"] ?? "GMT+0"

                let locationText = name

                if(country !== undefined && country.length) {
                    if(admin1 !== undefined && admin1.length) {
                        locationText = `${name} (${admin1}, ${country})`
                    } else {
                        locationText = `${name} (${country})`
                    }
                }

                let weatherRequest = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current=temperature_2m,weather_code,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=${timezone}`

                append({
                           "locationText": locationText,
                           "weatherRequest": weatherRequest
                       })

                console.log(locationIndex, name, admin1, country, "|", locationText)
                console.log(weatherRequest)
            }

            busy = false

            updated()
        })
    }
}
