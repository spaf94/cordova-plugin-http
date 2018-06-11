package com.dev.spaf94.sfhttpapp;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.dev.spaf94.sfhttplib.SFHttp;
import com.dev.spaf94.sfhttplib.SFHttpResult;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        String endpoint = "log-in?first-time=true";
        String headers = "{\"Content-Type\":\"application/json\",\"Accept\":\"application/json\"}";
        String body = "{\"email\":\"5developersplus1@gmail.com\",\"password\": \"5developers+1\"}";

        String getEndPoint = "new-password/5developersplus1@gmail.com";

        SFHttp sfHttp = new SFHttp(){
            @Override
            public void onPostFinished(SFHttpResult sfHttpResult) {
                super.onPostFinished(sfHttpResult);
            }

            @Override
            public void onGetFinished(SFHttpResult sfHttpResult) {
                super.onGetFinished(sfHttpResult);
            }
        };

        sfHttp.setBaseAddress("https://demo.tellspec.com:443/v1/");
        sfHttp.setTimeouts(3500, 4500);

        sfHttp.sendGet(getEndPoint, headers);
    }
}
