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
import android.view.Display;
import android.widget.Toast;
import android.widget.LinearLayout;
import android.widget.FrameLayout;

import java.util.UUID;
import java.lang.Math;

import com.facebook.ads.*;
//import com.facebook.ads.a.ag;
import com.facebook.ads.internal.util.t;


public class FBMediumRectController extends Extension
{

    private static LinearLayout layout;

    private static boolean initialized = false;
    private static String deviceIdHash = null;

    private static boolean adLoadedMediumrect = false;
    private static boolean adFailedToLoadMediumrect = false;
    private static boolean adClickedMediumrect = false;
    private static boolean adFinishClickedMediumrect = false;
    private static boolean adOpenMediumrect = false;


    static AdView adViewRectangle;
    
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
    
    
    static public void initMediumRect(final String adPlaceID, final int position, final int mode)
    {

        mainActivity.runOnUiThread(new Runnable()
        {
            public void run()
            {
                
            // Create a MediumRect banner's ad view with a unique placement ID (generate your own on the Facebook app settings).
            // Use different ID for each ad placement in your app.
            adViewRectangle = new AdView(mainActivity, adPlaceID, AdSize.RECTANGLE_HEIGHT_250);
                

            layout = new LinearLayout(mainActivity);

            //setMediumRectPosition(position);

            if(mode == 1) //is testmode
            {
                
                AdSettings.addTestDevice(getDeviceIdHash(mainActivity));
            }

            // Initiate a request to load an ad.
            adViewRectangle.loadAd();

            // Set a listener to get notified on changes or when the user interact with the ad.
            adViewRectangle.setAdListener(new AdListener()
            {
                @Override
                public void onAdLoaded(Ad ad)
                {
                    if (!initialized)
                    {
                        initialized = true;
                        setMediumRectPosition(position);
                        
                        int scale = Math.round(mainActivity.getResources().getDisplayMetrics().density);
                        
                        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams((int)(300*scale),  LayoutParams.FILL_PARENT);
                        params.gravity = Gravity.CENTER;
                      
                        //mainActivity.addContentView(layout,new LayoutParams((int)(300*scale), LayoutParams.FILL_PARENT));
                        mainActivity.addContentView(layout,params);
                        layout.addView(adViewRectangle);

                    }

                    adLoadedMediumrect = true;
                    adFailedToLoadMediumrect = false;
                }

                @Override
                public void onError(Ad ad, AdError error)
                {
                    adLoadedMediumrect = false;
                    adFailedToLoadMediumrect = true;
                }

                @Override
                public void onAdClicked(Ad ad)
                {
                    adClickedMediumrect = true;
                    adFinishClickedMediumrect = true;
                }

            });
            }
        });
    }
    
    static public void setMediumRectPosition(final int position)
    {
        mainActivity.runOnUiThread(new Runnable()
                                   {
            public void run()
            {
                if(position == 0) //Bottom-Center
                {
                    layout.setGravity(Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL);
                }
                else if (position == 1) //Center
                {
                    layout.setGravity(Gravity.CENTER_VERTICAL | Gravity.CENTER_HORIZONTAL);
                }
                else if (position == 2) //Top-Center
                {
                    layout.setGravity(Gravity.TOP | Gravity.CENTER_HORIZONTAL);
                }
            }
        });
    }


    static public void showMediumRect()
    {
        mainActivity.runOnUiThread(new Runnable()
        {
            public void run()
            {
                if(adViewRectangle != null && adViewRectangle.getVisibility() == AdView.GONE)
                {
                    adViewRectangle.setVisibility(AdView.VISIBLE);
                    adOpenMediumrect = true;
                }
            }
        });
    }

    static public void hideMediumRect()
    {
        mainActivity.runOnUiThread(new Runnable()
        {
            public void run()
            {
                if(adViewRectangle != null && adViewRectangle.getVisibility() == AdView.VISIBLE)
                {
                    adViewRectangle.setVisibility(AdView.GONE);

                }
            }
        });
    }

    static public boolean mediumRectIsLoaded()
    {
        if (adLoadedMediumrect)
        {
            adLoadedMediumrect = false;
            return true;
        }
        return false;
    }

    static public boolean mediumRectFailedToLoad()
    {
        if (adFailedToLoadMediumrect)
        {
            adFailedToLoadMediumrect = false;
            return true;
        }
        return false;
    }

    static public boolean mediumRectWasOpened()
    {
        if (adOpenMediumrect)
        {
            adOpenMediumrect = false;
            return true;
        }
        return false;
    }


    static public boolean mediumRectWasClicked()
    {
        if (adClickedMediumrect)
        {
            adClickedMediumrect = false;
            return true;
        }
        return false;
    }

    static public boolean mediumRectWasFinishClicked()
    {
        if (adFinishClickedMediumrect)
        {
            adFinishClickedMediumrect = false;
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
                    if (adViewRectangle != null) {
                        adViewRectangle.destroy();
                    }
                }
            });
            
            super.onDestroy();
        }
                             

}
