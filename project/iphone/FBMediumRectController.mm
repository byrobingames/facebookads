#import "FBViewController.h"
#import <UIKit/UIKit.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>


// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


using namespace facebook;

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


@interface FBMediumRectViewController : NSObject <FBAdViewDelegate>
{
    FBAdView *mediumRectAdView_;
    
    BOOL showMediumrect;
    BOOL didLoadMediumrect;
    BOOL didFailToLoadMediumrect;
    BOOL willOpenMediumrect;
    BOOL didClickMediumrect;
    BOOL didFinishClickMediumrect;
}


@property (nonatomic, assign) BOOL showMediumrect;
@property (nonatomic, assign) BOOL didLoadMediumrect;
@property (nonatomic, assign) BOOL didFailToLoadMediumrect;
@property (nonatomic, assign) BOOL willOpenMediumrect;
@property (nonatomic, assign) BOOL didClickMediumrect;
@property (nonatomic, assign) BOOL didFinishClickMediumrect;

@end

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //


@implementation FBMediumRectViewController

@synthesize showMediumrect;
@synthesize didLoadMediumrect;
@synthesize didFailToLoadMediumrect;
@synthesize willOpenMediumrect;
@synthesize didClickMediumrect;
@synthesize didFinishClickMediumrect;


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

// ---------- // ---------- // Start Mediumrect // ---------- // ---------- //

- (void)initMediumRect:(NSString*)mediumRectPlaceID withPosition:(int)position withMode:(int)mode
{
    showMediumrect = NO;
    
    UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    // Create a banner's ad view with a unique placement ID (generate your own on the Facebook app settings).
    // Use different ID for each ad placement in your app.
    FBAdSize adSize = kFBAdSizeHeight250Rectangle;
    mediumRectAdView_ = [[FBAdView alloc] initWithPlacementID:mediumRectPlaceID
                                                           adSize:adSize
                                               rootViewController:root];
    
    
    // Set a delegate to get notified on changes or when the user interact with the ad.
    [mediumRectAdView_ setDelegate:self];
    
    
    
    // When testing on a device, add its hashed ID to force test ads.
    // The hash ID is printed to console when running on a device.
    if (mode == 1)
    {
        [FBAdSettings addTestDevice:[self getDeviceID]];
    }
    
    NSLog(@"Load Medium Rect Ad.");
    // Initiate a request to load an ad.
    [mediumRectAdView_ loadAd];
    
    [self setMediumRectPosition:position];
    
    
    // Set autoresizingMask so the rotation is automatically handled
    mediumRectAdView_.autoresizingMask =
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin;
        
    // Add adView to the view hierarchy.
    [root.view addSubview:mediumRectAdView_];
    
    showMediumrect = YES;
    
}

- (void) setMediumRectPosition:(int)position
{
    FBAdSize adSize = kFBAdSizeHeight250Rectangle;
    
    if (position == 0) // Reposition the adView to the bottom of the screen
    {
        CGSize viewSize = [self getCorrectedSize];
        viewSize = CGSizeMake(viewSize.width, viewSize.height);
        CGFloat bottomAlignedY = viewSize.height - adSize.size.height;
        CGFloat leftAlignedX = (viewSize.width/2) - 150;
        [mediumRectAdView_ setFrame:CGRectMake(leftAlignedX, bottomAlignedY, 300, adSize.size.height)];
        
    }else if (position == 1) // Reposition the adView to the center of the screen
    {
        CGSize viewSize = [self getCorrectedSize];
        viewSize = CGSizeMake(viewSize.width, viewSize.height);
        CGFloat topAlignedY = viewSize.height - ((adSize.size.height/2) + (viewSize.height/2));
        CGFloat leftAlignedX = (viewSize.width/2) - 150;
        [mediumRectAdView_ setFrame:CGRectMake(leftAlignedX, topAlignedY, 300, adSize.size.height)];
        
    }else // Reposition the adView to the top of the screen
    {
        CGSize viewSize = [self getCorrectedSize];
        viewSize = CGSizeMake(viewSize.width, viewSize.height);
        CGFloat topAlignedY = 0;
        CGFloat leftAlignedX = (viewSize.width/2) - 150;
        [mediumRectAdView_ setFrame:CGRectMake(leftAlignedX, topAlignedY, 300, adSize.size.height)];
        
    }
    
    if (showMediumrect)
    {
        [self showMediumRectNow];
    }
}

    

- (void) showMediumRectNow
{
    mediumRectAdView_.hidden = NO;
     //NSLog(@"Show Medium Rect Ad.");
}

- (void) hideMediumRectNow
{
    mediumRectAdView_.hidden = YES;
}

- (void)adViewDidClick:(FBAdView *)adView
{
    didClickMediumrect = YES;
    //NSLog(@"Ad was clicked.");
}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView
{
    didFinishClickMediumrect = YES;
    //NSLog(@"Ad did finish click handling.");
}

- (void)adViewDidLoad:(FBAdView *)adView
{

    didLoadMediumrect = YES;
    //NSLog(@"Ad was loaded.");
}

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error
{
        [self hideMediumRectNow];
    
    didFailToLoadMediumrect = YES;
    //NSLog(@"Ad failed to load with error: %@", error);
}

- (void)adViewWillLogImpression:(FBAdView *)adView
{
    willOpenMediumrect = YES;
    //NSLog(@"Ad impression is being captured.");
}

- (CGSize)getCorrectedSize
{
    CGSize correctSize;
    UIInterfaceOrientation toOrientation = [UIApplication sharedApplication].statusBarOrientation;
    correctSize = [[UIScreen mainScreen] bounds].size;
    
    return correctSize;
}

// ---------- // ---------- // End MediumRec // ---------- // ---------- //



namespace facebook
{
    static FBMediumRectViewController *mediumRectController;
    
    void initFBMediumRect(const char* mediumRectPlaceID, int position, int mode)
    {
        if(mediumRectController == NULL)
        {
            mediumRectController = [[FBMediumRectViewController alloc] init];
        }
        
        NSString* newmediumRectPlaceID = [NSString stringWithUTF8String:mediumRectPlaceID];

        [mediumRectController initMediumRect:newmediumRectPlaceID withPosition:position withMode:mode];
    }
    
    void setFBMediumRectPosition(int position)
    {
        if(mediumRectController != NULL)
        {
            [mediumRectController setMediumRectPosition:position];
        }
    }
    
    void showFBMediumRect()
    {
        if(mediumRectController != NULL)
        {
            mediumRectController.showMediumrect = YES;
            [mediumRectController showMediumRectNow];
        }
    }
    
    void hideFBMediumRect()
    {
        if(mediumRectController != NULL)
        {
             mediumRectController.showMediumrect = NO;
            [mediumRectController hideMediumRectNow];
        }
    }
    
    bool adDidLoadMediumRect()
    {
        if(mediumRectController != NULL)
        {
            if (mediumRectController.didLoadMediumrect)
            {
                mediumRectController.didLoadMediumrect = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidFailToLoadMediumRect()
    {
        if(mediumRectController != NULL)
        {
            if (mediumRectController.didFailToLoadMediumrect)
            {
                mediumRectController.didFailToLoadMediumrect = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adMediumRectWasOpened()
    {
        if(mediumRectController != NULL)
        {
            if (mediumRectController.willOpenMediumrect)
            {
                mediumRectController.willOpenMediumrect = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidClickMediumRect()
    {
        if(mediumRectController != NULL)
        {
            if (mediumRectController.didClickMediumrect)
            {
                mediumRectController.didClickMediumrect = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adDidFinishClickMediumRect()
    {
        if(mediumRectController != NULL)
        {
            if (mediumRectController.didFinishClickMediumrect)
            {
                mediumRectController.didFinishClickMediumrect = NO;
                return true;
            }
        }
        return false;
    }
}

@end

// ---------- // ---------- // ---------- // ---------- // ---------- // ---------- //

