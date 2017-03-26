package com.byrobin.FaceBook;

import org.haxe.extension.Extension;


import android.app.Activity;
import android.content.Context;
import android.content.res.Configuration;
import android.content.SharedPreferences;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.Toast;
import android.widget.LinearLayout;

import java.util.UUID;

import com.facebook.ads.*;
//import com.facebook.ads.a.ag;
import com.facebook.ads.internal.util.t;


public class FBInterstitialController extends Extension
{

    private static LinearLayout layout;

    private static String deviceIdHash = null;
	private static String palceID;
	private static int testMode;

    private static boolean intDidLoad = false;
    private static boolean intDidFailToLoad = false;
    private static boolean intClicked = false;
    private static boolean intFinishClicked = false;
    private static boolean intIsOpen = false;
    
    private static boolean isAdLoaded = false;


    static InterstitialAd interstitialAd;
    
    public static String getDeviceIdHash(Context var0) { //get's device hash id.
        
        SharedPreferences var1 = var0.getSharedPreferences("FBAdPrefs", 0);
        deviceIdHash = var1.getString("deviceIdHash", (String)null);
        //if(s.a(deviceIdHash)) {
        if(deviceIdHash == null || deviceIdHash.length() <= 0){
            deviceIdHash = t.b(UUID.randomUUID().toString());
            var1.edit().putString("deviceIdHash", deviceIdHash).apply();
            
        }
        return deviceIdHash;
    }
    
    
    static public void initInterstitial(final String adPlaceID, final int mode)
    {
        mainActivity.runOnUiThread(new Runnable()
        {
        	public void run()
        	{
                palceID = adPlaceID;
				testMode = mode;
            }
        });
    }
	static public void loadInterstitial()
    {

        mainActivity.runOnUiThread(new Runnable()
        {
            public void run()
            {
					if (interstitialAd != null) {
                    interstitialAd.destroy();
                    interstitialAd = null;
                }
				
                // Create the interstitial unit with a placement ID (generate your own on the Facebook app settings).
                // Use different ID for each ad placement in your app.
                interstitialAd = new InterstitialAd(mainActivity, palceID);

          
            if(testMode == 1) //is testmode
            {
                
                AdSettings.addTestDevice(getDeviceIdHash(mainActivity));
            }


			// Set a listener to get notified on changes or when the user interact with the ad.
            interstitialAd.setAdListener(new InterstitialAdListener()
                
            {
                @Override
                public void onAdLoaded(Ad ad)
                {
		 
						intDidLoad = true;
                        intDidFailToLoad = false;
                        isAdLoaded = true;
                }

                @Override
                public void onError(Ad ad, AdError error)
                {
                    	intDidLoad = false;
                        intDidFailToLoad = true;
                        isAdLoaded = false;
                }
				
				@Override
    			public void onInterstitialDisplayed(Ad ad) 
				{
       				 intIsOpen = true;
    			}

    			@Override
   				public void onInterstitialDismissed(Ad ad) 
				{

        			// Cleanup.
        			interstitialAd.destroy();
        			interstitialAd = null;
                    isAdLoaded = false;
    			}

                @Override
                public void onAdClicked(Ad ad)
                {
                    intClicked = true;
					intFinishClicked = true;
                }

            });
			
			interstitialAd.loadAd();
            }
        });
    }
	
	

     static public void showInterstitial()
    {
        mainActivity.runOnUiThread(new Runnable()
        {
        	public void run()
        	{
				//if (interstitialAd.isAdLoaded())
                if(isAdLoaded)
				{
                    interstitialAd.show();
                }
            }
        });
    }

    static public boolean intIsLoaded()
    {
        if (intDidLoad)
        {
            intDidLoad = false;
            return true;
        }
        return false;
    }

    static public boolean intFailedToLoad()
    {
        if (intDidFailToLoad)
        {
            intDidFailToLoad = false;
            return true;
        }
        return false;
    }

    static public boolean intWasOpened()
    {
        if (intIsOpen)
        {
            intIsOpen = false;
            return true;
        }
        return false;
    }


    static public boolean intWasClicked()
    {
        if (intClicked)
        {
            intClicked = false;
            return true;
        }
        return false;
    }

    static public boolean intWasFinishClicked()
    {
        if (intFinishClicked)
        {
            intFinishClicked = false;
            return true;
        }
        return false;
    }
    
    @Override
    public void onDestroy() {
        if (interstitialAd != null) {
            interstitialAd.destroy();
            interstitialAd = null;
        }
        super.onDestroy();
    }
                             

}
