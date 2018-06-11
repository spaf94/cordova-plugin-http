package cordova.plugin.sfhttp;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.dev.spaf94.sfhttplib.SFHttp;
import com.dev.spaf94.sfhttplib.SFHttpResult;

/**
 * This class echoes a string called from JavaScript.
 */
public class SFHttpPlugin extends CordovaPlugin {

  private SFHttp sfHttp = null;
  private CallbackContext onPostFinishedCallback = null;
  private CallbackContext onGetFinishedCallback = null;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        boolean result = true;

        if(action.equals("sendPost")){
          this.sendPost(args, callbackContext);
        }else if(action.equals("sendGet")){
          this.sendGet(args, callbackContext);
        }else if (action.equals("setBaseAddress")) {
          this.setBaseAddress(args, callbackContext);
        }else if (action.equals("setTimeouts")) {
          this.setTimeouts(args, callbackContext);
        }else{
          result = false;
        }

        return result;
    }

    private void initializeSFHttp(){
        if(this.sfHttp == null){
          this.sfHttp = new SFHttp(){
            @Override
            public void onPostFinished(SFHttpResult sfHttpResult) {
                super.onPostFinished(sfHttpResult);
                onPostFinishedPlugin(sfHttpResult);
            }

            @Override
            public void onGetFinished(SFHttpResult sfHttpResult) {
                super.onGetFinished(sfHttpResult);
                onGetFinishedPlugin(sfHttpResult);
            }
          };
        }
    }

    private void setBaseAddress(JSONArray args, CallbackContext callbackContext) {
      try{
        this.initializeSFHttp();

        String baseAddress = args.getString(0);
        this.sfHttp.setBaseAddress(baseAddress);

        callbackContext.success("OK");
      }catch(Exception e){
        callbackContext.error(e.getMessage());
      }
    }

    private void setTimeouts(JSONArray args, CallbackContext callbackContext) {
      try{
        this.initializeSFHttp();

        int connectTimeout = args.getInt(0);
        int readTimeout = args.getInt(1);

        this.sfHttp.setTimeouts(connectTimeout, readTimeout);

        callbackContext.success("OK");
      }catch(Exception e){
        callbackContext.error(e.getMessage());
      }
    }

    private void sendPost(JSONArray args, CallbackContext callbackContext){
      try{
        this.initializeSFHttp();

        String endpoint = args.getString(0);
        String jsonHeaders = args.getString(1);
        String body = args.getString(2);

        this.setOnPostFinishedCallback(callbackContext);
        this.sfHttp.sendPost(endpoint, jsonHeaders, body);

        callbackContext.sendPluginResult(this.createResult(true, true, "OK"));
      }catch(Exception e){
        callbackContext.sendPluginResult(this.createResult(false, true, e.getMessage()));
      }
    }

    private void setOnPostFinishedCallback(CallbackContext callbackContext){
      this.onPostFinishedCallback = callbackContext;
    }

    private void onPostFinishedPlugin(SFHttpResult sfHttpResult){
      if(this.onPostFinishedCallback != null && sfHttpResult != null){
        if(sfHttpResult.isSuccess){
          this.onPostFinishedCallback.sendPluginResult(this.createResult(true, true, sfHttpResult.response));
        }else{
          this.onPostFinishedCallback.sendPluginResult(this.createResult(false, true, sfHttpResult.response));
        }
      }
    }

    private void sendGet(JSONArray args, CallbackContext callbackContext){
      try{
        String endpoint = args.getString(0);
        String jsonHeaders = args.getString(1);

        this.setOnGetFinishedCallback(callbackContext);
        this.sfHttp.sendGet(endpoint, jsonHeaders);

        callbackContext.sendPluginResult(this.createResult(true, true, "OK"));
      }catch(Exception e){
        callbackContext.sendPluginResult(this.createResult(false, true, e.getMessage()));
      }
    }

    private void setOnGetFinishedCallback(CallbackContext callbackContext){
      this.onGetFinishedCallback = callbackContext;
    }

    private void onGetFinishedPlugin(SFHttpResult sfHttpResult){
      if(this.onGetFinishedCallback != null && sfHttpResult != null){
        if(sfHttpResult.isSuccess){
          this.onGetFinishedCallback.sendPluginResult(this.createResult(true, true, sfHttpResult.response));
        }else{
          this.onGetFinishedCallback.sendPluginResult(this.createResult(false, true, sfHttpResult.response));
        }
      }
    }

    private PluginResult createResult(boolean isSucess, boolean keepCallback, String message){
      PluginResult result = null;

      if(isSucess){
        result = new PluginResult(PluginResult.Status.OK, message);
      }else{
        result = new PluginResult(PluginResult.Status.OK, message);
      }

      result.setKeepCallback(keepCallback);

      return result;
    }
}
