package com.dev.spaf94.sfhttplib;

public class SFHttpResult {
    public boolean isSuccess;
    public String response;

    public SFHttpResult(){

    }

    public SFHttpResult(boolean isSuccess, String response){
        this.isSuccess = isSuccess;
        this.response = response;
    }
}
