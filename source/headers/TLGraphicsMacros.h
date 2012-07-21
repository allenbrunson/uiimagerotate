// TLGraphicsMacros.h -- inline utility functions
// by allen brunson  february 17 2010


/******************************************************************************/
/*                                                                            */
/***  inline graphics functions                                             ***/
/*                                                                            */
/******************************************************************************/

// context functions

CG_INLINE void TLContextAddLineToPoint(CGContextRef context, CGPoint point)
{
    CGContextAddLineToPoint(context, point.x, point.y);
}

CG_INLINE void TLContextMoveToPoint(CGContextRef context, CGPoint point)
{
    CGContextMoveToPoint(context, point.x, point.y);
}

CG_INLINE void TLContextRestore(CGContextRef context)
{
    CGContextRestoreGState(context);
}

CG_INLINE CGContextRef TLContextSave(void)
{
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctxt);
    return ctxt;
}

// degrees to radians, useful for affine translations

CG_INLINE CGFloat TLDegreesToRadians(CGFloat degrees)
{
    return M_PI * (degrees / 180.0);
}

// start an image context

CG_INLINE CGContextRef TLGraphicsBeginImageContext(CGSize size)
{
    if (UIGraphicsBeginImageContextWithOptions == NULL)
    {
        UIGraphicsBeginImageContext(size);
    }
    else
    {
        UIGraphicsBeginImageContextWithOptions(size, FALSE, 0.0);
    }
    
    return UIGraphicsGetCurrentContext();
}

// end an image context

CG_INLINE UIImage* TLGraphicsEndImageContext(void)
{
    UIImage* imag = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imag;
}

// center point of a rect

CG_INLINE CGPoint TLPointCenter(CGRect rect)
{
    CGPoint  cgpt = CGPointZero;

    cgpt.x = rect.origin.x + floor(rect.size.width  / 2.0);
    cgpt.y = rect.origin.y + floor(rect.size.height / 2.0);

    return cgpt;
}

// center left point of a rect

CG_INLINE CGPoint TLPointCenterLeft(CGRect rect)
{
    CGPoint  cgpt = CGPointZero;

    cgpt.x = CGRectGetMinX(rect);
    cgpt.y = rect.origin.y + floor(rect.size.height / 2.0);

    return cgpt;
}

// center right point of a rect

CG_INLINE CGPoint TLPointCenterRight(CGRect rect)
{
    CGPoint  cgpt = CGPointZero;

    cgpt.x = CGRectGetMaxX(rect);
    cgpt.y = rect.origin.y + floor(rect.size.height / 2.0);

    return cgpt;
}

// lower center point of a rect

CG_INLINE CGPoint TLPointLowerCenter(CGRect rect)
{
    CGPoint  cgpt = CGPointZero;

    cgpt.x = rect.origin.x + floor(rect.size.width / 2.0);
    cgpt.y = CGRectGetMaxY(rect);

    return cgpt;
}

// lower left point of a rect

CG_INLINE CGPoint TLPointLowerLeft(CGRect rect)
{
    return CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
}

// lower right point of a rect

CG_INLINE CGPoint TLPointLowerRight(CGRect rect)
{
    return CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
}

// upper center point of a rect

CG_INLINE CGPoint TLPointUpperCenter(CGRect rect)
{
    CGPoint  cgpt = CGPointZero;

    cgpt.x = rect.origin.x + floor(rect.size.width / 2.0);
    cgpt.y = CGRectGetMinY(rect);

    return cgpt;
}

// upper left point of a rect

CG_INLINE CGPoint TLPointUpperLeft(CGRect rect)
{
    return CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
}

// upper right point of a rect

CG_INLINE CGPoint TLPointUpperRight(CGRect rect)
{
    return CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
}

// move 'target' to the bottom of 'rect'

CG_INLINE CGRect TLRectBottom(CGRect rect, CGRect target)
{
    target.origin.y = rect.origin.y + rect.size.height - target.size.height;
    
    return target;
}

// center 'target' over 'rect'

CG_INLINE CGRect TLRectCenter(CGRect rect, CGRect target)
{
    const CGFloat  xoff = floor((rect.size.width  - target.size.width)  / 2.0);
    const CGFloat  yoff = floor((rect.size.height - target.size.height) / 2.0);
    
    target.origin.x = rect.origin.x + xoff;
    target.origin.y = rect.origin.y + yoff;
    
    return target;
}

// move 'target' to the far left of 'rect'

CG_INLINE CGRect TLRectLeft(CGRect rect, CGRect target)
{
    target.origin.x = rect.origin.x;
    
    return target;
}

// move 'target' to the far right of 'rect'

CG_INLINE CGRect TLRectRight(CGRect rect, CGRect target)
{
    target.origin.x = rect.origin.x + rect.size.width - target.size.width;
    
    return target;
}

// move 'target' to the top of 'rect'

CG_INLINE CGRect TLRectTop(CGRect rect, CGRect target)
{
    target.origin.y = rect.origin.y;
    
    return target;
}

// create a rect from a size

CG_INLINE CGRect TLRectWithSize(CGSize size)
{
    CGRect rect = CGRectZero;
    rect.size = size;
    return rect;
}

// "zooms" a rect by adding zoomSize pixels to each side. the returned rect
// will be centered directly over the old one.

CG_INLINE CGRect TLRectZoom(CGRect rect, CGFloat zoomSize)
{
    rect.origin.x    -= zoomSize;
    rect.origin.y    -= zoomSize;

    rect.size.width  += (zoomSize * 2.0);
    rect.size.height += (zoomSize * 2.0);

    return rect;
}

// square size

CG_INLINE CGSize TLSizeSquare(CGFloat size)
{
    return CGSizeMake(size, size);
}

// swap width and height of this size

CG_INLINE CGSize TLSizeSwap(CGSize size)
{
    const CGFloat  swap = size.width;

    size.width  = size.height;
    size.height = swap;

    return size;
}
