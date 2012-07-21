// TLMainView.m -- uiimagerotate main view
// by allen brunson  july 21 2012

#import "TLMainView.h"
#import "UIImageExtras.h"

static const CGFloat kButtonBorder =  3.0;
static const CGFloat kButtonSize   = 46.0;

@implementation TLMainView

@synthesize buttonDown, buttonLeft;
@synthesize buttonMirrored, buttonRight;
@synthesize buttonUp, image;

-(void)buttonProc:(TLSimpleButton*)sender
{
    // only one direction button should be selected
    if (sender.type != tlsbMirrored)
    {
        self.buttonDown.selected  = FALSE;
        self.buttonUp.selected    = FALSE;
        self.buttonLeft.selected  = FALSE;
        self.buttonRight.selected = FALSE;
    
        sender.selected = TRUE;
    }
    
    // make an image in the new orientation
    [self makeNewImage];
}

-(void)dealloc
{
    self.buttonDown     = nil;
    self.buttonLeft     = nil;
    self.buttonMirrored = nil;
    self.buttonRight    = nil;
    self.buttonUp       = nil;
    self.image          = nil;
    
    [super dealloc];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self.image drawCenteredInRect:self.rectImage];
}

// convert current button state into image orientation value

-(UIImageOrientation)imageOrientation
{
    const BOOL  mirr = self.buttonMirrored.selected;
    
    if (self.buttonLeft.selected)
    {
        if (!mirr) return UIImageOrientationLeft;
        return UIImageOrientationLeftMirrored;
    }
    
    if (self.buttonRight.selected)
    {
        if (!mirr) return UIImageOrientationRight;
        return UIImageOrientationRightMirrored;
    }
    
    if (self.buttonDown.selected)
    {
        if (!mirr) return UIImageOrientationDown;
        return UIImageOrientationDownMirrored;
    }
    
    assert(self.buttonUp.selected);
    
    if (!mirr) return UIImageOrientationUp;
    return UIImageOrientationUpMirrored;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.autoresizingMask = TLAutoresizingWidthHeight;
    self.backgroundColor  = [UIColor grayColor];
    
    self.buttonDown       = [self makeButtonType:tlsbDown];
    self.buttonLeft       = [self makeButtonType:tlsbLeft];
    self.buttonMirrored   = [self makeButtonType:tlsbMirrored];
    self.buttonRight      = [self makeButtonType:tlsbRight];
    self.buttonUp         = [self makeButtonType:tlsbUp];
    self.image            = [self makeImage:UIImageOrientationUp];
    
    self.buttonMirrored.selected = FALSE;
    self.buttonUp.selected       = TRUE;
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.buttonDown.frame     = self.rectButtonDown;
    self.buttonLeft.frame     = self.rectButtonLeft;
    self.buttonMirrored.frame = self.rectButtonMirrored;
    self.buttonRight.frame    = self.rectButtonRight;
    self.buttonUp.frame       = self.rectButtonUp;
}

+(TLMainView*)mainView
{
    const CGRect rect = [[UIScreen mainScreen] bounds];
    return [[[self alloc] initWithFrame:rect] autorelease];
}

-(TLSimpleButton*)makeButtonType:(TLSimpleButtonType)type
{
    const CGRect     rect = [self rectButtonType:type];
    TLSimpleButton*  bttn = [TLSimpleButton buttonWithFrame:rect type:type];
    
    [bttn addTarget:self action:@selector(buttonProc:)
     forControlEvents:UIControlEventTouchUpInside];
     
    [self addSubview:bttn];
    
    return bttn;
}

-(UIImage*)makeImage:(UIImageOrientation)imageOrientation
{
    UIImage*      imag = nil;
    const CGRect  rect = self.rectImage;
    
    imag = [UIImage imageNamed:@"test.jpg"];
    imag = [imag rotate:imageOrientation];
    imag = [imag scaleToFit:rect.size];
    
    return imag;
}

-(void)makeNewImage
{
    [self setImage:[self makeImage:self.imageOrientation]];
    [self setNeedsDisplay];
}

-(CGRect)rectButtonDown
{
    const CGRect  bnds = self.rectMain;
    CGRect        rect = bnds;
    
    rect.size.height = kButtonSize;
    rect.size.width -= (kButtonSize * 2.0);
    
    rect = TLRectCenter(bnds, rect);
    rect = TLRectBottom(bnds, rect);
    rect = TLRectZoom(rect, -kButtonBorder);
    
    return rect;
}

-(CGRect)rectButtonLeft
{
    const CGRect  bnds = self.rectMain;
    CGRect        rect = bnds;
    
    rect.size.width   = kButtonSize;
    rect.size.height -= (kButtonSize * 2.0);
    
    rect = TLRectCenter(bnds, rect);
    rect = TLRectLeft(bnds, rect);
    rect = TLRectZoom(rect, -kButtonBorder);
    
    return rect;
}

-(CGRect)rectButtonMirrored
{
    const CGRect  bnds = self.bounds;
    CGRect        rect = bnds;
    
    rect.size.height = kButtonSize;
    rect.size.width -= (kButtonSize * 2.0);
    
    rect = TLRectCenter(bnds, rect);
    rect = TLRectBottom(bnds, rect);
    rect = TLRectZoom(rect, -kButtonBorder);
    
    return rect;
}

-(CGRect)rectButtonRight
{
    const CGRect  bnds = self.rectMain;
    CGRect        rect = bnds;
    
    rect.size.width   = kButtonSize;
    rect.size.height -= (kButtonSize * 2.0);
    
    rect = TLRectCenter(bnds, rect);
    rect = TLRectRight(bnds, rect);
    rect = TLRectZoom(rect, -kButtonBorder);
    
    return rect;
}

-(CGRect)rectButtonType:(TLSimpleButtonType)type
{
    switch (type)
    {
        case tlsbDown:     return self.rectButtonDown;
        case tlsbLeft:     return self.rectButtonLeft;
        case tlsbMirrored: return self.rectButtonMirrored;
        case tlsbRight:    return self.rectButtonRight;
        case tlsbUp:       return self.rectButtonUp;
        case tlsbUnknown:  break;
    }
    
    assert(FALSE);
    return CGRectZero;
}

-(CGRect)rectButtonUp
{
    const CGRect  bnds = self.rectMain;
    CGRect        rect = bnds;
    
    rect.size.height = kButtonSize;
    rect.size.width -= (kButtonSize * 2.0);
    
    rect = TLRectCenter(bnds, rect);
    rect = TLRectTop(bnds, rect);
    rect = TLRectZoom(rect, -kButtonBorder);
    
    return rect;
}

// the image to display goes here

-(CGRect)rectImage
{
    return TLRectZoom(self.rectMain, -kButtonSize);
}

// includes everything but the mirrored button

-(CGRect)rectMain
{
    const CGRect  bnds = self.bounds;
    CGRect        rect = bnds;
    
    rect.size.height -= kButtonSize;
    
    return TLRectTop(bnds, rect);
}

@end
