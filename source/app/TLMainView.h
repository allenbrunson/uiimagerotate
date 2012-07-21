// TLMainView.h -- uiimagerotate main view
// by allen brunson  july 21 2012

#import "TLSimpleButton.h"


/******************************************************************************/
/*                                                                            */
/***  class defines                                                         ***/
/*                                                                            */
/******************************************************************************/

enum
{
    TLAutoresizingWidthHeight = UIViewAutoresizingFlexibleWidth +
     UIViewAutoresizingFlexibleHeight
};


/******************************************************************************/
/*                                                                            */
/***  TLMainView class                                                      ***/
/*                                                                            */
/******************************************************************************/

@interface TLMainView: UIView
{
    @private
    
    TLSimpleButton*  buttonDown;
    TLSimpleButton*  buttonLeft;
    TLSimpleButton*  buttonMirrored;
    TLSimpleButton*  buttonRight;
    TLSimpleButton*  buttonUp;
    UIImage*         image;
}

// properties

@property(nonatomic,retain) TLSimpleButton*  buttonDown;
@property(nonatomic,retain) TLSimpleButton*  buttonLeft;
@property(nonatomic,retain) TLSimpleButton*  buttonMirrored;
@property(nonatomic,retain) TLSimpleButton*  buttonRight;
@property(nonatomic,retain) TLSimpleButton*  buttonUp;
@property(nonatomic,retain) UIImage*         image;

// class methods

+(TLMainView*)mainView;

// construction and destruction

-(void)dealloc;
-(id)initWithFrame:(CGRect)frame;

// instance methods

-(UIImageOrientation)imageOrientation;
-(void)makeNewImage;

// @private

-(void)buttonProc:(TLSimpleButton*)sender;

-(TLSimpleButton*)makeButtonType:(TLSimpleButtonType)type;
-(UIImage*)makeImage:(UIImageOrientation)imageOrientation;

-(CGRect)rectButtonDown;
-(CGRect)rectButtonLeft;
-(CGRect)rectButtonMirrored;
-(CGRect)rectButtonRight;
-(CGRect)rectButtonType:(TLSimpleButtonType)type;
-(CGRect)rectButtonUp;

-(CGRect)rectImage;
-(CGRect)rectMain;

// UIView methods

-(void)drawRect:(CGRect)rect;
-(void)layoutSubviews;

@end


/******************************************************************************/
/*                                                                            */
/***  TLMainView class                                                      ***/
/*                                                                            */
/******************************************************************************

overview
--------

main view for uiimagerotate demo program

*/
