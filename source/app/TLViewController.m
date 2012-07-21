// TLViewController.m -- uiimagerotate view controller
// by allen brunson  may 20 2012

#import "TLMainView.h"
#import "TLViewController.h"

@implementation TLViewController

+(TLViewController*)controller
{
    return [[[self alloc] initWithNibName:nil bundle:nil] autorelease];
}

-(void)dealloc
{
    self.view = nil;
    
    [super dealloc];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)orient
{
    [super didRotateFromInterfaceOrientation:orient];
    [self.mainView makeNewImage];
}

-(id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle
{
    self = [super initWithNibName:nibName bundle:bundle];
    if (!self) return nil;
    
    return self;
}

-(TLMainView*)mainView
{
    return (TLMainView*) self.view;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orient
{
    return TRUE;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [TLMainView mainView];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    self.view = nil;
}

@end
