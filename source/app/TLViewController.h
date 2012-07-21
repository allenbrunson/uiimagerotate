// TLViewController.h -- uiimagerotate view controller
// by allen brunson  may 20 2012

#import "TLMainView.h"

@interface TLViewController: UIViewController
{
    @private
}

// class methods

+(TLViewController*)controller;

// construction and destruction

-(void)dealloc;
-(id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)bundle;

// instance methods

-(TLMainView*)mainView;

// UIViewController methods

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)orient;
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orient;

-(void)viewDidLoad;
-(void)viewDidUnload;

@end
