package com.dev.spaf94.sfhttplib;

import android.os.AsyncTask;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Iterator;

import static com.dev.spaf94.sfhttplib.SFHttp.connectTimeout;
import static com.dev.spaf94.sfhttplib.SFHttp.readTimeout;
import static java.net.HttpURLConnection.HTTP_OK;

public class SFHttpGetTask extends AsyncTask<String, Integer, SFHttpResult> {
    @Override
    protected SFHttpResult doInBackground(String... strings) {
        return sendGetAsync(strings[0], strings[1]);
    }

    private SFHttpResult sendGetAsync(String urlString, String jsonHeaders){
        SFHttpResult digitalarHttpResult = new SFHttpResult();

        try{
            int i=0;
            String key = null;
            String value = null;

            JSONObject headers = new JSONObject(jsonHeaders);
            Iterator<String> keys = headers.keys();
            URL url = new URL(urlString);

            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            connection.setConnectTimeout(connectTimeout);
            connection.setReadTimeout(readTimeout);
            connection.setRequestMethod("GET");
            connection.setDoInput(true);

            while (keys.hasNext()){
                key = keys.next();
                value = headers.getString(key);
                connection.setRequestProperty(key, value);
            }

            int result = connection.getResponseCode();
            InputStream inputStream = null;

            if(result == HTTP_OK){
                inputStream  = connection.getInputStream();
            }else{
                inputStream  = connection.getErrorStream();
            }

            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
            String line = null;

            while((line = bufferedReader.readLine() ) != null) {
                digitalarHttpResult.response = line;
            }

            connection.disconnect();

            digitalarHttpResult.isSuccess = (result == 200);
        }catch (Exception e){
            digitalarHttpResult.isSuccess = false;
            digitalarHttpResult.response = e.getMessage();
        }

        return digitalarHttpResult;
    }
}
