#import "FBViewController.h"
#import <UIKit/UIKit.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>


// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


using namespace facebook;

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


@interface FBInterstitialViewController : NSObject <FBInterstitialAdDelegate>
{
    FBInterstitialAd *interstitialAd_;
    
    BOOL didLoadInt;
    BOOL didFailToLoadInt;
    BOOL willOpenInt;
    BOOL didClickInt;
    BOOL didFinishClickInt;
    BOOL testMode;
    NSString* placeID;
}


@property (nonatomic, assign) BOOL didLoadInt;
@property (nonatomic, assign) BOOL didFailToLoadInt;
@property (nonatomic, assign) BOOL willOpenInt;
@property (nonatomic, assign) BOOL didClickInt;
@property (nonatomic, assign) BOOL didFinishClickInt;

@end

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


@implementation FBInterstitialViewController

@synthesize didLoadInt;
@synthesize didFailToLoadInt;
@synthesize willOpenInt;
@synthesize didClickInt;
@synthesize didFinishClickInt;


// ---------- // ---------- // Get DeviceId for test // ---------- // ---------- //
- (NSString *)getDeviceID{
    NSUUID* adid = [[ASIdentifierManager sharedManager] advertisingIdentifier];
    const char *cStr = [adid.UUIDString UTF8String];
    unsigned char digest[20];
    
    CC_SHA1( cStr, strlen(cStr), digest ); // This is the SHA1 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    
    return  resultString;
}

// ---------- // ---------- // Start Interstitial // ---------- // ---------- //

- (void)initInterstitial:(NSString*)intPlaceID withMode:(int)mode
{
    placeID = intPlaceID;
    [placeID retain];
    
    if (mode == 1) {
        testMode = YES;
    }else{
        testMode = NO;
    }
}

- (void)loadInterstitial
{
    
    // Create the interstitial unit with a placement ID (generate your own on the Facebook app settings).
    // Use different ID for each ad placement in your app.
    interstitialAd_ = [[FBInterstitialAd alloc] initWithPlacementID:placeID];
    
    // Set a delegate to get notified on changes or when the user interact with the ad.
    [interstitialAd_ setDelegate:self];
    
    // When testing on a device, add its hashed ID to force test ads.
    // The hash ID is printed to console when running on a device.
    if (testMode)
    {
        [FBAdSettings addTestDevice:[self getDeviceID]];
    }
    
    // Initiate the request to load the ad.
    [interstitialAd_ loadAd];
    
}

- (void)showInterstitial
{
        // Ad is ready, present it!
        UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [interstitialAd_ showAdFromRootViewController:root];
    
}

- (void)interstitialAdDidLoad:(FBInterstitialAd *)interstitialAd
{
    didLoadInt = YES;
    didFailToLoadInt = NO;
    //NSLog(@"Interstitial ad was loaded. Can present now.");
}

- (void)interstitialAd:(FBInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    didFailToLoadInt = YES;
    didLoadInt = NO;
    //NSLog(@"Interstitial failed to load with error: %@", error.description);
}

- (void)interstitialAdDidClick:(FBInterstitialAd *)interstitialAd
{
    didClickInt = YES;
    didFinishClickInt = YES;
    //NSLog(@"Interstitial was clicked.");
}

- (void)interstitialAdDidClose:(FBInterstitialAd *)interstitialAd
{
    
    //NSLog(@"Interstitial closed.");
    
    // Optional, Cleaning up.
    interstitialAd_ = nil;
}

- (void)interstitialAdWillClose:(FBInterstitialAd *)interstitialAd
{
    //NSLog(@"Interstitial will close.");
}

- (void)interstitialAdWillLogImpression:(FBInterstitialAd *)interstitialAd
{
    willOpenInt = YES;
    //NSLog(@"Interstitial impression is being captured.");
}


// ---------- // ---------- // End Interstitial // ---------- // ---------- //



namespace facebook
{
    static FBInterstitialViewController *interstitialController;
    
    void initFBInterstitial(const char* intPlaceID, int mode)
    {
        if(interstitialController == NULL)
        {
            interstitialController = [[FBInterstitialViewController alloc] init];
        }
        
        NSString* newIntPlaceID = [NSString stringWithUTF8String:intPlaceID];
        

        [interstitialController initInterstitial:newIntPlaceID withMode:mode];
    }
    
    void loadFBInterstitial()
    {

        [interstitialController loadInterstitial];
    }
    
    void showFBInterstitial()
    {

        [interstitialController showInterstitial];
    }
  
         
    bool adDidLoadInterstitial()
    {
        if(interstitialController != NULL)
        {
            if (interstitialController.didLoadInt)
            {
                interstitialController.didLoadInt = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidFailToLoadInterstitial()
    {
        if(interstitialController != NULL)
        {
            if (interstitialController.didFailToLoadInt)
            {
                interstitialController.didFailToLoadInt = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adIntWasOpened()
    {
        if(interstitialController != NULL)
        {
            if (interstitialController.willOpenInt)
            {
                interstitialController.willOpenInt = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidClickInt()
    {
        if(interstitialController != NULL)
        {
            if (interstitialController.didClickInt)
            {
                interstitialController.didClickInt = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidFinishClickInt()
    {
        if(interstitialController != NULL)
        {
            if (interstitialController.didFinishClickInt)
            {
                interstitialController.didFinishClickInt = NO;
                return true;
            }
        }
        return false;
    }
}

@end

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //

