// TLSimpleButton.h -- uiimagerotate button
// by allen brunson  july 19 2012


/******************************************************************************/
/*                                                                            */
/***  class defines                                                         ***/
/*                                                                            */
/******************************************************************************/

typedef enum
{
    tlsbUnknown,
    tlsbLeft,
    tlsbRight,
    tlsbUp,
    tlsbDown,
    tlsbMirrored
}   TLSimpleButtonType;


/******************************************************************************/
/*                                                                            */
/***  TLSimpleButton class                                                  ***/
/*                                                                            */
/******************************************************************************/

@interface TLSimpleButton: UIButton
{
    @private
    
    TLSimpleButtonType  type;
}

// properties

@property(nonatomic,assign) TLSimpleButtonType  type;

// class methods

+(TLSimpleButton*)buttonWithFrame:(CGRect)frame type:(TLSimpleButtonType)type;

// construction and destruction

-(void)dealloc;
-(id)initWithFrame:(CGRect)frame;

// @private

-(UIColor*)colorCurrent;

-(void)drawBackground;
-(void)drawRoundRect;
-(void)drawTriangle;

// UIView methods

-(void)drawRect:(CGRect)rect;

// UIControl methods

-(BOOL)beginTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;
-(void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event;

@end


/******************************************************************************/
/*                                                                            */
/***  TLSimpleButton class                                                  ***/
/*                                                                            */
/******************************************************************************

overview
--------

simple button for the uiimagerotate test project

*/
