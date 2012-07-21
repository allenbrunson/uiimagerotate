// TLSimpleButton.m -- uiimagerotate button
// by allen brunson  july 19 2012

#import "TLSimpleButton.h"

static CG_INLINE CGFloat cv(uint8_t color)
{
    CGFloat elem = color;
    elem = elem / 255.0;
    return elem;
}

static UIColor* colorRGB(uint8_t r, uint8_t g, uint8_t b)
{
    return [UIColor colorWithRed:cv(r) green:cv(g) blue:cv(b) alpha:cv(255)];
}

static void contextRoundRect(CGContextRef context, const CGRect rect,
 const CGFloat oval)
{
    const CGFloat  fw = rect.size.width  / oval;
    const CGFloat  fh = rect.size.height / oval;

    assert(oval >= 1.0);

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, oval, oval);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, fw, fh / 2.0);
    CGContextAddArcToPoint(context, fw,  fh,  fw / 2.0, fh,  1.0);
    CGContextAddArcToPoint(context, 0.0, fh,  0.0, fh / 2.0, 1.0);
    CGContextAddArcToPoint(context, 0.0, 0.0, fw / 2.0, 0.0, 1.0);
    CGContextAddArcToPoint(context, fw,  0.0, fw, fh / 2.0,  1.0);

    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

static void contextTriangle(CGContextRef context, const CGPoint p1,
 const CGPoint p2, const CGPoint p3)
{
    CGContextBeginPath(context);
    
    TLContextMoveToPoint(context,    p1);
    TLContextAddLineToPoint(context, p2);
    TLContextAddLineToPoint(context, p3);
    
    CGContextClosePath(context);
}

@implementation TLSimpleButton

@synthesize type;

-(BOOL)beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    const BOOL rval = [super beginTrackingWithTouch:touch withEvent:event];
    [self setNeedsDisplay];
    return rval;
}

+(TLSimpleButton*)buttonWithFrame:(CGRect)frame type:(TLSimpleButtonType)type
{
    TLSimpleButton*  bttn = [[[self alloc] initWithFrame:frame] autorelease];
    
    bttn.type = type;
    bttn.titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
    
    if (bttn.type == tlsbMirrored)
    {
        [bttn setTitle:@"Mirrored" forState:UIControlStateNormal];
    }
    
    return bttn;
}

-(UIColor*)colorCurrent
{
    if (self.selected)
    {
        return colorRGB(50, 63, 82);
    }
    else
    {    
        return colorRGB(228, 235, 247);
    }    
}

-(void)dealloc
{
    [super dealloc];
}

-(void)drawBackground
{
    if (self.type == tlsbMirrored)
    {
        [self drawRoundRect];
    }
    else
    {
        [self drawTriangle];
    }    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawBackground];
}

-(void)drawRoundRect
{
    CGContextRef  ctxt = TLContextSave();
    
    contextRoundRect(ctxt, self.bounds, 6.0);
    CGContextSetFillColorWithColor(ctxt, self.colorCurrent.CGColor);
    CGContextFillPath(ctxt);
    
    TLContextRestore(ctxt);
}

-(void)drawTriangle
{
    CGContextRef  ctxt = TLContextSave();
    const CGRect  rect = self.bounds;
    
    switch (self.type)
    {
        case tlsbUp:
        contextTriangle(ctxt, TLPointLowerLeft(rect), TLPointLowerRight(rect),
         TLPointUpperCenter(rect));
        break;
     
        case tlsbDown:
        contextTriangle(ctxt, TLPointUpperLeft(rect), TLPointUpperRight(rect),
         TLPointLowerCenter(rect));
        break;
        
        case tlsbLeft:
        contextTriangle(ctxt, TLPointUpperRight(rect), TLPointLowerRight(rect),
         TLPointCenterLeft(rect));
        break;
        
        case tlsbRight:
        contextTriangle(ctxt, TLPointUpperLeft(rect), TLPointLowerLeft(rect),
         TLPointCenterRight(rect));
        break;
        
        case tlsbMirrored:
        case tlsbUnknown:
        assert(FALSE);
        break;
    } 
    
    CGContextSetFillColorWithColor(ctxt, self.colorCurrent.CGColor);
    CGContextFillPath(ctxt);
    
    TLContextRestore(ctxt);
}

-(void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    [self setSelected:!self.selected];
    [self setNeedsDisplay];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

@end
