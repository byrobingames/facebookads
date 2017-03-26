#ifndef IPHONE
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include "FBViewController.h"
#include <stdio.h>

//--------------------------------------------------
// Change this to match your extension's ID
//--------------------------------------------------

using namespace facebook;


#ifdef IPHONE

//--------------------------------------------------
// Glues Haxe to native code.
//--------------------------------------------------

// Banner

void init_adbanner(value adPlaceID, value position, value mode)
{
	initFBBanner(val_string(adPlaceID), val_int(position), val_int(mode));
}
DEFINE_PRIM(init_adbanner, 3);

void init_adbanner_position(value position)
{
    setFBBannerPosition(val_int(position));
}
DEFINE_PRIM(init_adbanner_position, 1);

void show_adbanner()
{
	showFBBanner();
}
DEFINE_PRIM(show_adbanner, 0);

void hide_adbanner()
{
    hideFBBanner();
}
DEFINE_PRIM(hide_adbanner, 0);

static value get_banner_loaded()
{
    if (facebook::adDidLoadBanner())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_banner_loaded, 0);

static value get_banner_failed()
{
    if (facebook::adDidFailToLoadBanner())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_banner_failed, 0);

static value get_banner_opened()
{
    if (facebook::adBannerWasOpened())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_banner_opened, 0);

static value get_banner_click()
{
    if (facebook::adDidClick())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_banner_click, 0);

static value get_banner_finish_click()
{
    if (facebook::adDidFinishClick())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_banner_finish_click, 0);

//Medium Rect

void init_admediumrect(value mediumRectPlaceID, value position, value mode)
{
    initFBMediumRect(val_string(mediumRectPlaceID), val_int(position), val_int(mode));
}
DEFINE_PRIM(init_admediumrect, 3);

void init_admediumrect_position(value position)
{
    setFBMediumRectPosition(val_int(position));
}
DEFINE_PRIM(init_admediumrect_position, 1);

void show_admediumrect()
{
    showFBMediumRect();
}
DEFINE_PRIM(show_admediumrect, 0);

void hide_admediumrect()
 {
     hideFBMediumRect();
 }
 DEFINE_PRIM(hide_admediumrect, 0);

static value get_mediumrect_loaded()
{
    if (facebook::adDidLoadMediumRect())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_mediumrect_loaded, 0);

static value get_mediumrect_failed()
{
    if (facebook::adDidFailToLoadMediumRect())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_mediumrect_failed, 0);

static value get_mediumrect_opened()
{
    if (facebook::adMediumRectWasOpened())
            return val_true;
    return val_false;
}
DEFINE_PRIM(get_mediumrect_opened, 0);
 
static value get_mediumrect_click()
{
    if (facebook::adDidClickMediumRect())
            return val_true;
    return val_false;
}
DEFINE_PRIM(get_mediumrect_click, 0);
 
static value get_mediumrect_finish_click()
{
    if (facebook::adDidFinishClickMediumRect())
            return val_true;
    return val_false;
}
DEFINE_PRIM(get_mediumrect_finish_click, 0);

//Interstitial

void init_interstitial(value intPlaceID, value mode)
{
    initFBInterstitial(val_string(intPlaceID), val_int(mode));
}
DEFINE_PRIM(init_interstitial, 2);

void load_interstitial()
{
    loadFBInterstitial();
}
DEFINE_PRIM(load_interstitial, 0);

void show_interstitial()
{
    showFBInterstitial();
}
DEFINE_PRIM(show_interstitial, 0);

static value get_interstitial_loaded()
{
    if (facebook::adDidLoadInterstitial())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_interstitial_loaded, 0);

static value get_interstitial_failed()
{
    if (facebook::adDidFailToLoadInterstitial())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_interstitial_failed, 0);

static value get_interstitial_opened()
{
    if (facebook::adIntWasOpened())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_interstitial_opened, 0);

static value get_interstitial_click()
{
    if (facebook::adDidClickInt())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_interstitial_click, 0);

static value get_interstitial_finish_click()
{
    if (facebook::adDidFinishClickInt())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_interstitial_finish_click, 0);


#endif



//--------------------------------------------------
// IGNORE STUFF BELOW THIS LINE
//--------------------------------------------------

extern "C" void facebook_main()
{	
}
DEFINE_ENTRY_POINT(facebook_main);

extern "C" int facebook_register_prims()
{ 
    return 0; 
}