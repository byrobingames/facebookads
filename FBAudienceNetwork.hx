package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#else
import openfl.Lib;
#end

#if android
import openfl.utils.JNI;
#end

import scripts.ByRobinAssets;


class FBAudienceNetwork
{

 	private static var initializeBanner:Bool = true;
	private static var initializeMediumRect:Bool = true;
 
     #if android
    private static var _init_banner_func:Dynamic;
	private static var _set_banner_position_func:Dynamic;
    private static var _show_banner_func:Dynamic;
    private static var _hide_banner_func:Dynamic;
    private static var _banner_loaded_func:Dynamic;
    private static var _banner_failed_to_load_func:Dynamic;
    private static var _banner_was_opened_func:Dynamic;
    private static var _banner_was_clicked_func:Dynamic;
	private static var _banner_was_finish_clicked_func:Dynamic;
	
	private static var _init_mediumrect_func:Dynamic;
	private static var _set_mediumrect_position_func;
    private static var _show_mediumrect_func:Dynamic;
    private static var _hide_mediumrect_func:Dynamic;
    private static var _mediumrect_loaded_func:Dynamic;
    private static var _mediumrect_failed_to_load_func:Dynamic;
    private static var _mediumrect_was_opened_func:Dynamic;
    private static var _mediumrect_was_clicked_func:Dynamic;
	private static var _mediumrect_was_finish_clicked_func:Dynamic;
	
	private static var initializeInterstitial:Bool = true;
	private static var _init_int_func:Dynamic;
    private static var _load_int_func:Dynamic;
    private static var _show_int_func:Dynamic;
    private static var _int_did_load_func:Dynamic;
    private static var _int_did_fail_func:Dynamic;
	private static var _int_was_open_func:Dynamic;
	private static var _int_was_clicked_func:Dynamic;
	private static var _int_was_finish_clicked_func:Dynamic;
    #end

//-------------Banner ad------------------------------------------
 public static function initBanner(position:Int):Void
    {
		var mode:Int;
		var adID:String = ByRobinAssets.FBBannerPlacement;
		if(ByRobinAssets.FBTestAds)
		{
			mode = 1;
		}else{
			mode = 0;
		}
		
		if(adID == "")
		{
			if(mode == 1)
			{
				adID = "1537086959841884_1538124856404761"; // test placeID Don't use for Release
				
			}else
			{
				haxe.Log.trace("PlaceID connot be empty in Release Mode, turn on Test Mode");
			}
			
		}
	
        #if ios
        if(initializeBanner)
        {
            initAdBanner(adID, position, mode);
            initializeBanner = false;
        }
        else
        {
            showAdBanner();
        }
        #end
		
		#if android
        if(initializeBanner)
        {
            initializeBanner = false;

            if(_init_banner_func == null)
            {
                _init_banner_func = JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "initBanner", "(Ljava/lang/String;II)V", true);
            }
            var args = new Array<Dynamic>();
            args.push(adID);
            args.push(position);
            args.push(mode);
            _init_banner_func(args);
        }
        else
        {
            if(_show_banner_func == null)
            {
                _show_banner_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "showBanner", "()V", true);
            }
            var args = new Array<Dynamic>();
            _show_banner_func(args);
        }
        #end
    }
	
	public static function setBannerPosition(position:Int):Void	
	{
		#if ios
        setPositionAdBanner(position);
        #end
		
		#if android
        if(_set_banner_position_func == null)
        {
            _set_banner_position_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "setBannerPosition", "(I)V", true);
        }
        var args = new Array<Dynamic>();
		args.push(position);
        _set_banner_position_func(args);
        #end
	
	}

 	public static function showBanner():Void
    {
        #if ios
        showAdBanner();
        #end
		
		 #if android
        if(_show_banner_func == null)
        {
            _show_banner_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "showBanner", "()V", true);
        }
        var args = new Array<Dynamic>();
        _show_banner_func(args);
        #end
	}
    
	public static function hideBanner():Void
    {
        #if ios
        hideAdBanner();
        #end
		
	  	#if android
        if(_hide_banner_func == null)
        {
            _hide_banner_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "hideBanner", "()V", true);
        }
        var args = new Array<Dynamic>();
        _hide_banner_func(args);
        #end

    }
	
	public static function getBannerInfo(info:Int):Bool
    {
        if (info == 0)
        {
            #if ios
            return adDidLoadAd();
            #end
			
			#if android
            if (_banner_loaded_func == null)
            {
                _banner_loaded_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "bannerIsLoaded", "()Z", true);
            }
            
            return _banner_loaded_func();
            #end
        }
        else if (info == 1)
        {
            #if ios
            return adDidFailToLoadAd();
            #end
			
			#if android
            if (_banner_failed_to_load_func == null)
            {
                _banner_failed_to_load_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "bannerFailedToLoad", "()Z", true);
            }
            
            return _banner_failed_to_load_func();
            #end
        }
        else if (info == 2)
        {
            #if ios
            return adBannerWasOpened();
            #end
			
			#if android
            if (_banner_was_opened_func == null)
            {
                _banner_was_opened_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "bannerWasOpened", "()Z", true);
            }
            
            return _banner_was_opened_func();
            #end
		}
        else if (info == 3)
        {
            #if ios
            return adDidClick();
            #end
			
			 #if android
            if (_banner_was_clicked_func == null)
            {
                _banner_was_clicked_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "bannerWasClicked", "()Z", true);
            }
            
            return _banner_was_clicked_func();
            #end
        }
        else
        {
            #if ios
            return adDidFinishClick();
            #end
			
			 #if android
            if (_banner_was_finish_clicked_func == null)
            {
                _banner_was_finish_clicked_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBBannerController", "bannerWasFinishClicked", "()Z", true);
            }
            
            return _banner_was_finish_clicked_func();
            #end
			
        }
        
        return false;
    }
	
	//-------------MedeumRect banner ad------------------------------------------
	public static function initMediumRect(position:Int):Void
    {
		var mode:Int;
		var adID:String = ByRobinAssets.FBRectBannerPlacement;
		if(ByRobinAssets.FBTestAds)
		{
			mode = 1;
		}else{
			mode = 0;
		}
		
		if(adID == "")
		{
			if(mode == 1)
			{
				adID = "1537086959841884_1538457186371528"; // test placeID Don't use for Release
			}else
			{
				haxe.Log.trace("PlaceID connot be empty in Release Mode, turn on Test Mode");
			}
			
		}
	
        #if ios
        if(initializeMediumRect)
        {
            initAdMediumRect(adID, position, mode);
            initializeMediumRect = false;
        }
        else
        {
            showAdMediumRect();
        }
        #end
		
		#if android
        if(initializeMediumRect)
        {
            initializeMediumRect = false;

            if(_init_mediumrect_func == null)
            {
                _init_mediumrect_func = JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "initMediumRect", "(Ljava/lang/String;II)V", true);
            }
            var args = new Array<Dynamic>();
            args.push(adID);
            args.push(position);
            args.push(mode);
            _init_mediumrect_func(args);
        }
        else
        {
            if(_show_mediumrect_func == null)
            {
                _show_mediumrect_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "showMediumRect", "()V", true);
            }
            var args = new Array<Dynamic>();
            _show_mediumrect_func(args);
        }
        #end
		
    }
	
	public static function setMediumRectPosition(position:Int):Void	
	{
		#if ios
        setPositionAdMediumRect(position);
        #end
		
		#if android
        if(_set_mediumrect_position_func == null)
        {
            _set_mediumrect_position_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "setMediumRectPosition", "(I)V", true);
        }
        var args = new Array<Dynamic>();
		args.push(position);
        _set_mediumrect_position_func(args);
        #end
	
	}
	
	
	public static function  showMediumRect():Void
    {
        #if ios
        showAdMediumRect();
        #end
		
		#if android
        if(_show_mediumrect_func == null)
        {
            _show_mediumrect_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "showMediumRect", "()V", true);
        }
        var args = new Array<Dynamic>();
        _show_mediumrect_func(args);
        #end
		
	}
	
	public static function  hideMediumRect():Void
    {
        #if ios
        hideAdMediumRect();
        #end
		
		#if android
        if(_hide_mediumrect_func == null)
        {
            _hide_mediumrect_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "hideMediumRect", "()V", true);
        }
        var args = new Array<Dynamic>();
        _hide_mediumrect_func(args);
        #end
		
	}
	
	public static function getMediumRectInfo(info:Int):Bool
    {
        if (info == 0)
        {
            #if ios
            return adDidLoadAdMediumRect();
            #end
			
			#if android
            if (_mediumrect_loaded_func == null)
            {
                _mediumrect_loaded_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "mediumRectIsLoaded", "()Z", true);
            }
            
            return _mediumrect_loaded_func();
            #end
				
        }
		 else if (info == 1)
        {
            #if ios
            return adDidFailToLoadAdMediumRect();
            #end
			
			#if android
            if (_mediumrect_failed_to_load_func == null)
            {
                _mediumrect_failed_to_load_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "mediumRectFailedToLoad", "()Z", true);
            }
            
            return _mediumrect_failed_to_load_func();
            #end
        }
		 else if (info == 2)
        {
            #if ios
            return adMediumRectWasOpened();
            #end
			
			#if android
            if (_mediumrect_was_opened_func == null)
            {
                _mediumrect_was_opened_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "mediumRectWasOpened", "()Z", true);
            }
            
            return _mediumrect_was_opened_func();
            #end
        }
		 else if (info == 3)
        {
            #if ios
            return adDidClickMediumRect();
            #end
			
			 #if android
            if (_mediumrect_was_clicked_func == null)
            {
                _mediumrect_was_clicked_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "mediumRectWasClicked", "()Z", true);
            }
            
            return _mediumrect_was_clicked_func();
            #end
        }
		 else
        {
            #if ios
            return adDidFinishClickMediumRect();
            #end
			
			 #if android
            if (_mediumrect_was_finish_clicked_func == null)
            {
                _mediumrect_was_finish_clicked_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBMediumRectController", "mediumRectWasFinishClicked", "()Z", true);
            }
            
            return _mediumrect_was_finish_clicked_func();
            #end
        }
        
        return false;
    }
	
	//-------------Interstitial ad------------------------------------------
	
	
	 public static function initInterstitial():Void
    {
		var mode:Int;
		var adID:String = ByRobinAssets.FBInterstitialPlacement;
		if(ByRobinAssets.FBTestAds)
		{
			mode = 1;
		}else{
			mode = 0;
		}
	
		if(adID == "")
		{
			if(mode == 1)
			{
				adID = "1537086959841884_1538124856404761"; // test placeID Don't use for Release
				
			}else
			{
				haxe.Log.trace("PlaceID connot be empty in Release Mode, turn on Test Mode");
			}
			
		}
		
        #if ios
        fbInitInterstitial(adID, mode);
        #end
        
        #if android
        if(initializeInterstitial)
        {
            initializeInterstitial = false;

            if(_init_int_func == null)
            {
                _init_int_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBInterstitialController", "initInterstitial", "(Ljava/lang/String;I)V", true);
            }
            var args = new Array<Dynamic>();
            args.push(adID);
			args.push(mode);
            _init_int_func(args);
        }
        #end
    }
	
	    public static function loadInterstitial():Void
    {
        #if ios
        fbLoadInterstitial();
        #end
        
        #if android
        if(_load_int_func == null)
        {
            _load_int_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBInterstitialController", "loadInterstitial", "()V", true);
        }
        var args = new Array<Dynamic>();
        _load_int_func(args);
        #end
    }
    
    public static function showInterstitial():Void
    {
        #if ios
        fbShowInterstitial();
        #end
        
        #if android
        if(_show_int_func == null)
        {
            _show_int_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBInterstitialController", "showInterstitial", "()V", true);
        }
        var args = new Array<Dynamic>();
        _show_int_func(args);
        #end
    }
	
	public static function getInterstitialInfo(info:Int):Bool
    {
        if (info == 0)
        {
            #if ios
            return intDidLoad();
            #end

            #if android
            if(_int_did_load_func == null)
            {
                _int_did_load_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBInterstitialController", "intIsLoaded", "()Z", true);
            }
            var args = new Array<Dynamic>();
            return _int_did_load_func(args);
            #end
        }
        else if (info == 1)
        {
            #if ios
            return intDidFailToLoad();
            #end
            
            #if android
            if(_int_did_fail_func == null)
            {
                _int_did_fail_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBInterstitialController", "intFailedToLoad", "()Z", true);
            }
            var args = new Array<Dynamic>();
            return _int_did_fail_func(args);
            #end
        }
		else if (info == 2)
        {
            #if ios
            return interstitialWasOpened();
            #end
            
            #if android
            if(_int_was_open_func == null)
            {
                _int_was_open_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBInterstitialController", "intWasOpened", "()Z", true);
            }
            var args = new Array<Dynamic>();
            return _int_was_open_func(args);
            #end
        }
		else if (info == 3)
        {
            #if ios
            return didClickInterstitial();
            #end
            
            #if android
            if(_int_was_clicked_func == null)
            {
                _int_was_clicked_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBInterstitialController", "intWasClicked", "()Z", true);
            }
            var args = new Array<Dynamic>();
            return _int_was_clicked_func(args);
            #end
        }
		else
        {
            #if ios
            return didFinishClickInterstitial();
            #end
            
            #if android
            if(_int_was_finish_clicked_func == null)
            {
                _int_was_finish_clicked_func = openfl.utils.JNI.createStaticMethod("com/byrobin/FaceBook/FBInterstitialController", "intWasFinishClicked", "()Z", true);
            }
            var args = new Array<Dynamic>();
            return _int_was_finish_clicked_func(args);
            #end
        }
        
        return false;
    }

	#if ios
    private static var initAdBanner = Lib.load("facebook","init_adbanner",3);
	private static var setPositionAdBanner = Lib.load("facebook","init_adbanner_position",1);
	private static var showAdBanner = Lib.load("facebook","show_adbanner",0);
    private static var hideAdBanner = Lib.load("facebook","hide_adbanner",0);
	private static var adDidLoadAd = Lib.load("facebook","get_banner_loaded",0);
    private static var adDidFailToLoadAd = Lib.load("facebook","get_banner_failed",0);
    private static var adBannerWasOpened = Lib.load("facebook","get_banner_opened",0);
    private static var adDidClick = Lib.load("facebook","get_banner_click",0);
    private static var adDidFinishClick = Lib.load("facebook","get_banner_finish_click",0);
	
	private static var initAdMediumRect = Lib.load("facebook","init_admediumrect",3);
	private static var setPositionAdMediumRect = Lib.load("facebook","init_admediumrect_position",1);
	private static var showAdMediumRect = Lib.load("facebook","show_admediumrect",0);
	private static var hideAdMediumRect = Lib.load("facebook","hide_admediumrect",0);
	private static var adDidLoadAdMediumRect = Lib.load("facebook","get_mediumrect_loaded",0);
    private static var adDidFailToLoadAdMediumRect = Lib.load("facebook","get_mediumrect_failed",0);
    private static var adMediumRectWasOpened = Lib.load("facebook","get_mediumrect_opened",0);
    private static var adDidClickMediumRect = Lib.load("facebook","get_mediumrect_click",0);
    private static var adDidFinishClickMediumRect = Lib.load("facebook","get_mediumrect_finish_click",0);
	
	private static var fbInitInterstitial = Lib.load("facebook","init_interstitial",2);
    private static var fbLoadInterstitial = Lib.load("facebook","load_interstitial",0);
    private static var fbShowInterstitial = Lib.load("facebook","show_interstitial",0);
    private static var intDidLoad = Lib.load("facebook","get_interstitial_loaded",0);
    private static var intDidFailToLoad = Lib.load("facebook","get_interstitial_failed",0);
	private static var interstitialWasOpened = Lib.load("facebook","get_interstitial_opened",0);
    private static var didClickInterstitial = Lib.load("facebook","get_interstitial_click",0);
    private static var didFinishClickInterstitial = Lib.load("facebook","get_interstitial_finish_click",0);
    #end
	

}