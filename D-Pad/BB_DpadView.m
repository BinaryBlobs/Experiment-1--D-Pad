//
//  BB_DpadView.m
//  D-Pad
//
//  Created by Hugh on 10/9/12.
//  Copyright (c) 2012 Binary Blobs. All rights reserved.
//

#import "BB_DpadView.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(degrees) ((degrees) / 180.0  * M_PI)

@interface BB_DpadView ()
{
    UIImageView *knobView;
    UIImageView *ringView;
   
    CGPoint ptStart;
}
@end


@implementation BB_DpadView

@synthesize mode;

@synthesize ringName;
@synthesize knobName;

//--------------------------------------------------------------------------------------------------------------

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"Calling initWithFrame:");

    self = [super initWithFrame:frame];
    if (self)
    {
        // defaults
        knobName = @"D-Knob.png";
        ringName = @"D-Ring.png";
    }

    CGPoint middle = [self center];
    
    float ring_sz = 80;
    float knob_sz = (ring_sz * 0.35);
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Create KNOB...
    //
    CGRect knobRect = CGRectMake(middle.x, middle.y, knob_sz, knob_sz);
        
    knobView             = [[UIImageView alloc] initWithFrame: knobRect];
    knobView.image       = [UIImage imageNamed: knobName];
    knobView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview: knobView];
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Create RING...
    //
    CGRect ringRect = CGRectMake(middle.x, middle.y, ring_sz, ring_sz);
    
    ringView             = [[UIImageView alloc] initWithFrame: ringRect];
    ringView.image       = [UIImage imageNamed:ringName];
    ringView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview: ringView];
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    knobView.center = middle;
    ringView.center = middle;
    
    ringView.alpha = 0.85;
    
    return self;
}

//--------------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
   // [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//--------------------------------------------------------------------------------------------------------------

CGFloat AngleBetweenTwoPoints2(CGPoint point1, CGPoint point2)
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    
    CGFloat rads  = atan2( dy, dx); // Range: 0 to 2*pi radians
    CGFloat angle = fmodf(rads, (2*M_PI) );// + M_PI/2;  // +PI/2 to offset (always) to 12 O'Clock
    
    return angle;
};

//--------------------------------------------------------------------------------------------------------------

CGFloat DistanceBetweenTwoPoints2(CGPoint point1, CGPoint point2)
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    
    return sqrt( dx*dx + dy*dy );
};

//--------------------------------------------------------------------------------------------------------------

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint point = [touch locationInView:touch.view];
    
    knobView.alpha = 1.0;
    
    double radius = ringView.bounds.size.width/2;
    
    CGFloat distance = DistanceBetweenTwoPoints2(ringView.center, point);
    CGFloat angle    = AngleBetweenTwoPoints2(ringView.center,    point);
    
    if(distance > radius)
    {
        //inside the circle
        distance = radius;
    }
    
    
    CGFloat rounded = 0;
    CGFloat degrees = RADIANS_TO_DEGREES(angle);
    
    switch(mode)
    {
        case BB_DpadViewMode8way:
        {            
            rounded = (CGFloat) ( ((int) degrees / 45) * 45);
            angle   = DEGREES_TO_RADIANS(rounded);            
        }
        break;
            
        case BB_DpadViewMode4way:
        {
            rounded = (CGFloat) ( ((int) degrees / 90) * 90);
            angle   = DEGREES_TO_RADIANS(rounded);
        }
        break;
          
        case BB_DpadViewModeAnalog:
        default:
        break;

    }//SWITCH;

    point.x = ringView.center.x + distance * cos(angle);
    point.y = ringView.center.y + distance * sin(angle);
    
    NSLog(@"   rounded = %0.2f  degrees = %f", rounded, degrees);
    
	knobView.center = point;
}

//--------------------------------------------------------------------------------------------------------------

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self touchesBegan:touches withEvent:event];
}

//--------------------------------------------------------------------------------------------------------------

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//knobView.center = ringView.center;
    
    [UIView beginAnimations : @"Centering" context:nil];
    [UIView setAnimationDuration: 0.15];
    [UIView setAnimationBeginsFromCurrentState:FALSE];
    
    knobView.center = ringView.center;
    knobView.alpha  = 0.55;
    
    [UIView commitAnimations];
}

//--------------------------------------------------------------------------------------------------------------
@end

