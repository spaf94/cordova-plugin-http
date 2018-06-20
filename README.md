# Cordova plugin http

Cordova plugin to do http requests in your cordova mobile app.

## How to install
` cordova plugin add https://github.com/spaf94/cordova-plugin-http `

## How to use
#### Set base address 
```javascript
function setBaseAddress(){

  var callbackAlert = function(msg){
    console.log(msg);
  };

  sfHttpPlugin.setBaseAddress('http://localhost/apibaseaddress', callbackAlert, callbackAlert);
}
```

#### Set timeouts 
```javascript
function setTimeouts(){

  var connectTimeout = 5000; //5 seconds 
  var readTimeout = 4000; //4 seconds

  var callbackAlert = function(msg){
    console.log(msg);
  };

  sfHttpPlugin.setTimeouts(connectTimeout, readTimeout, callbackAlert, callbackAlert);
}
```

#### Send get 
```javascript
function sendGet(){

  var getEndpoint = 'getUserList';
  var headers = '{"Content-Type":"application/json","Accept":"application/json"}';

  var callbackAlert = function(msg){
    console.log(msg);
  };

  sfHttpPlugin.sendGet(getEndpoint, headers, callbackAlert, callbackAlert);
}
```

#### Send post 
```javascript
function sendPost(){

  var postEndpoint = 'login?firsttime=true';
  var headers = '{"Content-Type":"application/json","Accept":"application/json"}';
  var body = '{"email":"test@email.com","password":"testPwd"}';

  var callbackAlert = function(msg){
    console.log(msg);
  };

  sfHttpPlugin.sendPost(postEndpoint, headers, body, callbackAlert, callbackAlert);
}
```

## Issues
If you find any bugs, please submit an [issue](https://github.com/spaf94/cordova-plugin-http/issues/new/).
