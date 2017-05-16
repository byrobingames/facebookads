#import "FBViewController.h"
#import <UIKit/UIKit.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>


// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


using namespace facebook;

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


@interface FBBannerViewController : NSObject <FBAdViewDelegate>
{
    FBAdView *adView_;
    
    BOOL showBanner;
    BOOL didLoadBanner;
    BOOL didFailToLoadBanner;
    BOOL willOpenBanner;
    BOOL didClick;
    BOOL didFinishClick;
}


@property (nonatomic, assign) BOOL showBanner;
@property (nonatomic, assign) BOOL didLoadBanner;
@property (nonatomic, assign) BOOL didFailToLoadBanner;
@property (nonatomic, assign) BOOL willOpenBanner;
@property (nonatomic, assign) BOOL didClick;
@property (nonatomic, assign) BOOL didFinishClick;

@end

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


@implementation FBBannerViewController

@synthesize showBanner;
@synthesize didLoadBanner;
@synthesize didFailToLoadBanner;
@synthesize willOpenBanner;
@synthesize didClick;
@synthesize didFinishClick;


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

// ---------- // ---------- // Start Banner // ---------- // ---------- //

- (void)initBanner:(NSString*)adPlaceID withPosition:(int)position withMode:(int)mode
{
    showBanner = NO;
    
    UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    // Create a banner's ad view with a unique placement ID (generate your own on the Facebook app settings).
    // Use different ID for each ad placement in your app.
    BOOL isIPAD = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    FBAdSize adSize = isIPAD ? kFBAdSizeHeight90Banner : kFBAdSizeHeight50Banner;
    adView_ = [[FBAdView alloc] initWithPlacementID:adPlaceID
                                                    adSize:adSize
                                                    rootViewController:root];
    
    // Set a delegate to get notified on changes or when the user interact with the ad.
    [adView_ setDelegate:self];
    
    
    
    // When testing on a device, add its hashed ID to force test ads.
    // The hash ID is printed to console when running on a device.
    if (mode == 1)
    {
        [FBAdSettings addTestDevice:[self getDeviceID]];
    }
    
    // Initiate a request to load an ad.
    [adView_ loadAd];
    
    [self setBannerPosition:position];
    
    
    // Set autoresizingMask so the rotation is automatically handled
    adView_.autoresizingMask =
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin;
    
    // Add adView to the view hierarchy.
    [root.view addSubview:adView_];
    
    showBanner = YES;
    
}

- (void) setBannerPosition:(int)position
{
    
    BOOL isIPAD = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    FBAdSize adSize = isIPAD ? kFBAdSizeHeight90Banner : kFBAdSizeHeight50Banner;
    
    if (position == 0) // Reposition the adView to the bottom of the screen
    {
        CGSize viewSize = [self getCorrectedSize];
        viewSize = CGSizeMake(viewSize.width, viewSize.height);
        CGFloat bottomAlignedY = viewSize.height - adSize.size.height;
        [adView_ setFrame:CGRectMake(0, bottomAlignedY, viewSize.width, adSize.size.height)];
        
    }else // Reposition the adView to the top of the screen
    {
        CGSize viewSize = [self getCorrectedSize];
        viewSize = CGSizeMake(viewSize.width, viewSize.height);
        CGFloat topAlignedY = 0;
        [adView_ setFrame:CGRectMake(0, topAlignedY, viewSize.width, adSize.size.height)];
        
    }
    
    if (showBanner)
    {
        [self showBannerNow];
    }
    
}


- (void) showBannerNow
{

    adView_.hidden = NO;
}

- (void) hideBannerNow
{
    adView_.hidden = YES;
}

- (void)adViewDidClick:(FBAdView *)adView
{
    didClick = YES;
    //NSLog(@"Ad was clicked.");
}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView
{
    didFinishClick = YES;
    //NSLog(@"Ad did finish click handling.");
}

- (void)adViewDidLoad:(FBAdView *)adView
{

    didLoadBanner = YES;
    //NSLog(@"Ad was loaded.");
}

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error
{
   
    [self hideBannerNow];
    
    didFailToLoadBanner = YES;
    //NSLog(@"Ad failed to load with error: %@", error);
}

- (void)adViewWillLogImpression:(FBAdView *)adView
{
    willOpenBanner = YES;
    //NSLog(@"Ad impression is being captured.");
}

- (CGSize)getCorrectedSize
{
    CGSize correctSize;
    UIInterfaceOrientation toOrientation = [UIApplication sharedApplication].statusBarOrientation;
    correctSize = [[UIScreen mainScreen] bounds].size;
    
    return correctSize;
}

// ---------- // ---------- // End Banner // ---------- // ---------- //



namespace facebook
{
    static FBBannerViewController *adController;
    
    void initFBBanner(const char* adPlaceID, int position, int mode)
    {
        if(adController == NULL)
        {
            adController = [[FBBannerViewController alloc] init];
        }
        
        NSString* newadPlaceID = [NSString stringWithUTF8String:adPlaceID];
        

        [adController initBanner:newadPlaceID withPosition:position withMode:mode];
    }
    
    void setFBBannerPosition(int position)
    {
        if(adController != NULL)
        {
            [adController setBannerPosition:position];
        }
    }
    
    void showFBBanner()
    {
        if(adController != NULL)
        {
            adController.showBanner = YES;
            [adController showBannerNow];
        }
    }
    
    void hideFBBanner()
    {
        if(adController != NULL)
        {
            adController.showBanner = NO;
            [adController hideBannerNow];
        }
    }
    
    bool adDidLoadBanner()
    {
        if(adController != NULL)
        {
            if (adController.didLoadBanner)
            {
                adController.didLoadBanner = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidFailToLoadBanner()
    {
        if(adController != NULL)
        {
            if (adController.didFailToLoadBanner)
            {
                adController.didFailToLoadBanner = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adBannerWasOpened()
    {
        if(adController != NULL)
        {
            if (adController.willOpenBanner)
            {
                adController.willOpenBanner = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidClick()
    {
        if(adController != NULL)
        {
            if (adController.didClick)
            {
                adController.didClick = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidFinishClick()
    {
        if(adController != NULL)
        {
            if (adController.didFinishClick)
            {
                adController.didFinishClick = NO;
                return true;
            }
        }
        return false;
    }
}

@end

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //

