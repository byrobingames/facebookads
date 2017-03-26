#ifndef FaceBook
#define FaceBook

namespace facebook
{
    //Banner
    void initFBBanner(const char* adPlaceID, int position, int mode);
    void setFBBannerPosition(int position);
    void showFBBanner();
    void hideFBBanner();
    bool adDidLoadBanner();
    bool adDidFailToLoadBanner();
    bool adBannerWasOpened();
    bool adDidClick();
    bool adDidFinishClick();
    
    //Medium Rect banner
    void initFBMediumRect(const char* mediumRectPlaceID, int position, int mode);
    void setFBMediumRectPosition(int position);
    void showFBMediumRect();
    void hideFBMediumRect();
    bool adDidLoadMediumRect();
    bool adDidFailToLoadMediumRect();
    bool adMediumRectWasOpened();
    bool adDidClickMediumRect();
    bool adDidFinishClickMediumRect();
    
    //Interstitial
    void initFBInterstitial(const char* intPlaceID, int mode);
    void loadFBInterstitial();
    void showFBInterstitial();
    bool adDidLoadInterstitial();
    bool adDidFailToLoadInterstitial();
    bool adIntWasOpened();
    bool adDidClickInt();
    bool adDidFinishClickInt();
    
    
}

#endif
