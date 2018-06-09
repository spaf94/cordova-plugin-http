module.exports = {
    setBaseAddress: function (baseAddress, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "SFHttpPlugin", "setBaseAddress", [baseAddress]);
    },
    sendPost: function (endpoint, jsonHeaders, body, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "SFHttpPlugin", "sendPost", [endpoint, jsonHeaders, body]);
    },
    sendGet: function (endpoint, jsonHeaders, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "SFHttpPlugin", "sendGet", [endpoint, jsonHeaders]);
    },
    setTimeouts: function (connectTimeout, readTimeout, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "SFHttpPlugin", "setTimeouts", [connectTimeout, readTimeout]);
    }
};
