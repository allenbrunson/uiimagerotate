// AppDelegate.m -- uiimagerotate app delegate
// by allen brunson  may 20 2012

#import "TLViewController.h"

@interface TLAppDelegate: UIResponder <UIApplicationDelegate>
{
    @private
    
    UIWindow*          window;
    TLViewController*  viewController;
}

// properties

@property(nonatomic,retain) UIWindow*          window;
@property(nonatomic,retain) TLViewController*  viewController;

// construction and destruction

-(void)dealloc;
-(id)init;

// @private

-(UIWindow*)makeWindow;

// UIApplicationDelegate methods

-(BOOL)application:(UIApplication*)application
 didFinishLaunchingWithOptions:(NSDictionary*)launchOptions;
 
@end
