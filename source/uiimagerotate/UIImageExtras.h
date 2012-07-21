// UIImageExtras.h -- extra UIImage methods
// by allen brunson  march 29 2009


/******************************************************************************/
/*                                                                            */
/***  UIImage category                                                      ***/
/*                                                                            */
/******************************************************************************/

@interface UIImage (UIImageExtras)

// draw the image

-(void)drawCenteredInRect:(CGRect)rect;

// rotate UIImage to any angle

-(UIImage*)rotate:(UIImageOrientation)orient;

// rotate and scale image from camera

-(UIImage*)rotateAndScaleFromCameraWithMaxSize:(CGFloat)maxSize;

// scale functions

-(UIImage*)scaleToFit:(CGSize)bounds;
-(UIImage*)scaleToMaxWidthAndHeight:(CGFloat)maxSize;
-(UIImage*)scaleToSize:(CGSize)size;

// save in popular image file formats

-(NSData*)imageJPEGData;
-(NSData*)imageJPEGDataWithCompression:(CGFloat)compression;
-(NSData*)imagePNGData;

// utilities

-(CGRect)bounds;

@end


/******************************************************************************/
/*                                                                            */
/***  UIImage category                                                      ***/
/*                                                                            */
/******************************************************************************

overview
--------

extra methods for UIImage

*/
