// UIImageExtras.m -- extra UIImage methods
// by allen brunson  march 29 2009

#import "UIImageExtras.h"

@implementation UIImage (UIImageExtras)

-(CGRect)bounds
{
    return TLRectWithSize(self.size);
}

-(void)drawCenteredInRect:(CGRect)rect
{
    const CGRect cent = TLRectCenter(rect, self.bounds);
    [self drawAtPoint:TLPointUpperLeft(cent)];
}

-(NSData*)imageJPEGData
{
    return [self imageJPEGDataWithCompression:1.0];
}

// 0.0 is most compressed, 1.0 is highest quality
    
-(NSData*)imageJPEGDataWithCompression:(CGFloat)compression
{
    return UIImageJPEGRepresentation(self, compression);
}

-(NSData*)imagePNGData
{
    return UIImagePNGRepresentation(self);
}

// rotate an image to any 90-degree orientation, with or without mirroring.
// original code by kevin lohman, heavily modified by yours truly.
// http://blog.logichigh.com/2008/06/05/uiimage-fix/

-(UIImage*)rotate:(UIImageOrientation)orient
{
    CGRect             bnds = self.bounds;
    CGContextRef       ctxt = nil;
    const CGRect       rect = bnds;
    CGAffineTransform  tran = CGAffineTransformIdentity;

    switch (orient)
    {
        case UIImageOrientationUp:
        return self;

        case UIImageOrientationUpMirrored:
        tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
        tran = CGAffineTransformScale(tran, -1.0, 1.0);
        break;

        case UIImageOrientationDown:
        tran = CGAffineTransformMakeTranslation(rect.size.width,
         rect.size.height);
        tran = CGAffineTransformRotate(tran, TLDegreesToRadians(180.0));
        break;

        case UIImageOrientationDownMirrored:
        tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
        tran = CGAffineTransformScale(tran, 1.0, -1.0);
        break;

        case UIImageOrientationLeft:
        bnds.size = TLSizeSwap(bnds.size);
        tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
        tran = CGAffineTransformRotate(tran, TLDegreesToRadians(-90.0));
        break;

        case UIImageOrientationLeftMirrored:
        bnds.size = TLSizeSwap(bnds.size);
        tran = CGAffineTransformMakeTranslation(rect.size.height,
         rect.size.width);
        tran = CGAffineTransformScale(tran, -1.0, 1.0);
        tran = CGAffineTransformRotate(tran, TLDegreesToRadians(-90.0));
        break;

        case UIImageOrientationRight:
        bnds.size = TLSizeSwap(bnds.size);
        tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
        tran = CGAffineTransformRotate(tran, TLDegreesToRadians(90.0));
        break;

        case UIImageOrientationRightMirrored:
        bnds.size = TLSizeSwap(bnds.size);
        tran = CGAffineTransformMakeScale(-1.0, 1.0);
        tran = CGAffineTransformRotate(tran, TLDegreesToRadians(90.0));
        break;

        default:
        // orientation value supplied is invalid
        assert(FALSE);
        return nil;
    }

    ctxt = TLGraphicsBeginImageContext(bnds.size);

    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
        CGContextScaleCTM(ctxt, -1.0, 1.0);
        CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
        break;

        default:
        CGContextScaleCTM(ctxt, 1.0, -1.0);
        CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
        break;
    }

    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(ctxt, rect, self.CGImage);

    return TLGraphicsEndImageContext();
}

-(UIImage*)rotateAndScaleFromCameraWithMaxSize:(CGFloat)maxSize
{
    UIImage*                  imag = self;
    const UIImageOrientation  tilt = self.imageOrientation;
    
    // always scale first. if you try to rotate first, large images from the
    // camera will exhaust all available memory and abort your app. 

    imag = [imag scaleToMaxWidthAndHeight:maxSize];
    imag = [imag rotate:tilt];

    return imag;
}

// scale this image so that it is as large as possible to fit within 'bounds'

-(UIImage*)scaleToFit:(CGSize)bounds
{
    const CGSize  curr = self.size;
    CGFloat       scal = 0.0;
    CGSize        size = CGSizeZero;
    
    scal = MIN(bounds.width / curr.width, bounds.height / curr.height);
    
    size.width  = floor(curr.width  * scal);
    size.height = floor(curr.height * scal);
    
    assert(size.width  <= bounds.width);
    assert(size.height <= bounds.height);
    
    return [self scaleToSize:size];
}

// scale such that width and height are both maxSize or smaller

-(UIImage*)scaleToMaxWidthAndHeight:(CGFloat)maxSize
{
    const CGRect   bnds = self.bounds;
    const CGFloat  rtio = bnds.size.width / bnds.size.height;
    CGSize         size = CGSizeZero;

    if ((bnds.size.width <= maxSize) && (bnds.size.height <= maxSize))
    {
        return self;
    }

    if (rtio > 1.0)
    {
        size.width  = floor(maxSize);
        size.height = floor(maxSize / rtio);
    }
    else
    {
        size.width  = floor(maxSize * rtio);
        size.height = floor(maxSize);
    }

    return [self scaleToSize:size];
}

// this is the image scaling engine. all other scale methods are based on this.
// todo: see if it works acceptably when scaling up

-(UIImage*)scaleToSize:(CGSize)size
{
    const CGRect   bnds = self.bounds;
    CGContextRef   ctxt = nil;
    const CGFloat  scal = size.width / bnds.size.width;
    
    if (CGSizeEqualToSize(bnds.size, size)) return self;

    ctxt = TLGraphicsBeginImageContext(size);

    CGContextSetInterpolationQuality(ctxt, kCGInterpolationHigh);
    CGContextScaleCTM(ctxt, scal, -scal);
    CGContextTranslateCTM(ctxt, 0.0, -bnds.size.height);
    CGContextDrawImage(ctxt, bnds, self.CGImage);
    
    return TLGraphicsEndImageContext();
}

@end
