// AppDelegate.m -- uiimagerotate app delegate
// by allen brunson  may 20 2012

#import "TLAppDelegate.h"
#import "TLViewController.h"

int main(int argc, char** argv)
{
    @autoreleasepool
    {
        NSString* name = NSStringFromClass([TLAppDelegate class]);
        return UIApplicationMain(argc, argv, nil, name);
    }
}

@implementation TLAppDelegate

@synthesize window, viewController;

-(BOOL)application:(UIApplication*)application
 didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.window = [self makeWindow];
    self.viewController = [TLViewController controller];
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];
    
    return TRUE;
}

-(void)dealloc
{
    self.window         = nil;
    self.viewController = nil;
    
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (!self) return nil;
    
    return self;
}

-(UIWindow*)makeWindow
{
    const CGRect  rect = [[UIScreen mainScreen] bounds];
    UIWindow*     wind = [[[UIWindow alloc] initWithFrame:rect] autorelease];
    
    wind.backgroundColor = [UIColor grayColor];
    
    return wind;
}

@end
