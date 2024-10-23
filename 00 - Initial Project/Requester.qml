pragma Singleton
import QtQuick

QtObject {
    id: root

    function sendRequest(url, callback) {

        let request = new XMLHttpRequest()

        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                let response = {
                    status : request.status,
                    headers : request.getAllResponseHeaders(),
                    contentType : request.responseType,
                    content : request.response
                }

                console.log("URL:", url)
                console.log("RESPONSE:", response.content)

                callback(response)
            }
        }

        request.open("GET", url);
        request.send()
    }
}
