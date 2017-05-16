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
import com.facebook.ads.internal.util.*;

public class FBBannerController extends Extension
{

    private static LinearLayout layout;

    private static boolean initialized = false;
    private static String deviceIdHash = null;

    private static boolean adLoaded = false;
    private static boolean adFailedToLoad = false;
    private static boolean adClicked = false;
    private static boolean adFinishClicked = false;
    private static boolean adOpenBanner = false;


    static AdView adViewBanner;
    
    public static String getDeviceIdHash(Context var0) { //get's device hash id.
        
        SharedPreferences var1 = var0.getSharedPreferences("FBAdPrefs", 0);
        deviceIdHash = var1.getString("deviceIdHash", (String)null);
        //if(s.a(deviceIdHash)) {
        if(deviceIdHash == null || deviceIdHash.length() <= 0){
            deviceIdHash = s.b(UUID.randomUUID().toString());
            var1.edit().putString("deviceIdHash", deviceIdHash).apply();
            
        }
        return deviceIdHash;
    }
    
    public static boolean isTablet(Context context) { // checks if device is tablet
        return (context.getResources().getConfiguration().screenLayout
                & Configuration.SCREENLAYOUT_SIZE_MASK)
        >= Configuration.SCREENLAYOUT_SIZE_LARGE;
    }
    
    static public void initBanner(final String adPlaceID, final int position, final int mode)
    {

        mainActivity.runOnUiThread(new Runnable()
        {
            public void run()
            {
                
            // Create a banner's ad view with a unique placement ID (generate your own on the Facebook app settings).
            // Use different ID for each ad placement in your app.
            boolean isTablet = isTablet(mainActivity);
            adViewBanner = new AdView(mainActivity, adPlaceID, isTablet ? AdSize.BANNER_HEIGHT_90 : AdSize.BANNER_HEIGHT_50);
                

            layout = new LinearLayout(mainActivity);
                
            setBannerPosition(position);
            
            if(mode == 1) //is testmode
            {
                
                AdSettings.addTestDevice(getDeviceIdHash(mainActivity));
            }

            // Initiate a request to load an ad.
            adViewBanner.loadAd();

            // Set a listener to get notified on changes or when the user interact with the ad.
            adViewBanner.setAdListener(new AdListener()
            {
                @Override
                public void onAdLoaded(Ad ad)
                {
                    if (!initialized)
                    {
                        initialized = true;

                        layout.addView(adViewBanner);
                        mainActivity.addContentView(layout, new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT));

                    }

                    adLoaded = true;
                    adFailedToLoad = false;
                }
                
                @Override
                public void onLoggingImpression(Ad ad) {
                    //nothing to do
                }

                @Override
                public void onError(Ad ad, AdError error)
                {
                    adLoaded = false;
                    adFailedToLoad = true;
                }

                @Override
                public void onAdClicked(Ad ad)
                {
                    adClicked = true;
                    adFinishClicked = true;
                }

            });
            }
        });
    }
    
    static public void setBannerPosition(final int position)
    {
        mainActivity.runOnUiThread(new Runnable()
                                   {
            public void run()
            {
                if(position == 0) //Bottom-Center
                {
                    layout.setGravity(Gravity.CENTER_HORIZONTAL|Gravity.BOTTOM);
                }
                else if (position == 1) //Top-Center
                {
                    layout.setGravity(Gravity.CENTER_HORIZONTAL);
                }
            }
        });
    }


    static public void showBanner()
    {
        mainActivity.runOnUiThread(new Runnable()
        {
            public void run()
            {
                if(adViewBanner != null && adViewBanner.getVisibility() == AdView.GONE)
                {
                    adViewBanner.setVisibility(AdView.VISIBLE);
                    adOpenBanner = true;
                }
            }
        });
    }

    static public void hideBanner()
    {
        mainActivity.runOnUiThread(new Runnable()
        {
            public void run()
            {
                if(adViewBanner != null && adViewBanner.getVisibility() == AdView.VISIBLE)
                {
                    adViewBanner.setVisibility(AdView.GONE);

                }
            }
        });
    }

    static public boolean bannerIsLoaded()
    {
        if (adLoaded)
        {
            adLoaded = false;
            return true;
        }
        return false;
    }

    static public boolean bannerFailedToLoad()
    {
        if (adFailedToLoad)
        {
            adFailedToLoad = false;
            return true;
        }
        return false;
    }

    static public boolean bannerWasOpened()
    {
        if (adOpenBanner)
        {
            adOpenBanner = false;
            return true;
        }
        return false;
    }


    static public boolean bannerWasClicked()
    {
        if (adClicked)
        {
            adClicked = false;
            return true;
        }
        return false;
    }

    static public boolean bannerWasFinishClicked()
    {
        if (adFinishClicked)
        {
            adFinishClicked = false;
            return true;
        }
        return false;
    }
    
    @Override
     public void onDestroy() {
            mainActivity.runOnUiThread(new Runnable()
                                       {
                public void run()
                {
                    if (adViewBanner != null) {
                        adViewBanner.destroy();
                    }
                }
            });
            
            super.onDestroy();
        }
                             

}
