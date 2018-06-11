package com.dev.spaf94.sfhttplib;

public class SFHttp {
    private String baseAddress = null;
    public static int connectTimeout = 600000; //10 min default
    public static int readTimeout = 600000; //10 min default

    public void setBaseAddress(String baseAddress){
        this.baseAddress = baseAddress;
    }

    public void setTimeouts(int connectTimeout, int readTimeout){
        this.connectTimeout = connectTimeout;
        this.readTimeout = readTimeout;
    }

    public void onPostFinished(SFHttpResult sfHttpResult){

    }

    public void onGetFinished(SFHttpResult sfHttpResult){

    }

    public void sendPost(String endpoint, String jsonHeaders, String body){
        String urlString = this.baseAddress + endpoint;

        SFHttpPostTask task = new SFHttpPostTask(){
            @Override
            protected void onPostExecute(SFHttpResult sfHttpResult) {
                super.onPostExecute(sfHttpResult);
                onPostFinished(sfHttpResult);
            }
        };
        task.execute(urlString, jsonHeaders, body);
    }

    public void sendGet(String endpoint, String jsonHeaders){
        String urlString = this.baseAddress + endpoint;

        SFHttpGetTask task = new SFHttpGetTask(){
            @Override
            protected void onPostExecute(SFHttpResult sfHttpResult) {
                super.onPostExecute(sfHttpResult);
                onGetFinished(sfHttpResult);
            }
        };
        task.execute(urlString, jsonHeaders);
    }
}
