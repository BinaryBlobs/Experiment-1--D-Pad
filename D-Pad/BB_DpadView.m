//
//  BB_DpadView.m
//  D-Pad
//
//  Created by Binary Blobs on 10/9/12.
//  Copyright (c) 2012 Binary Blobs. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
// ================================================================================================

#import "BB_DpadView.h"

@interface BB_DpadView ()
{
    UIImageView *knobView;
    UIImageView *ringView;
   
    CGPoint ptStart;
    
    
    CGPoint knobPosition;
    CGFloat knobAngle;
    CGFloat knobPower;
    
    dispatch_queue_t backgroundQueue;
}

@end

CGFloat DistanceBetweenTwoPoints(CGPoint point1, CGPoint point2);
CGFloat AngleBetweenTwoPoints(CGPoint point1, CGPoint point2);

@implementation BB_DpadView

@synthesize mode;

@synthesize ringName;
@synthesize knobName;
@synthesize delegate;

//--------------------------------------------------------------------------------------------------------------

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
  //  self.backgroundColor = [UIColor blueColor]; // DEBUG
    
    if (self)
    {
        // defaults
        knobName = @"Knob.png";
        ringName = @"Ring.png";
        
        [self setMode: BB_DpadMode_Analog];
    }
  
    // Diameters...
    float ring_sz = frame.size.width;
    float knob_sz = (ring_sz * 0.35);
    
    self.autoresizesSubviews = YES;
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Create KNOB...
    //
    CGRect      knobRect = CGRectMake(0,0, knob_sz, knob_sz);
    
    knobView             = [[UIImageView alloc] initWithFrame: knobRect];
    knobView.image       = [UIImage imageNamed: knobName];
    knobView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview: knobView];
       
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    // Create RING...
    //
    CGRect      ringRect = CGRectMake(0,0, ring_sz, ring_sz);

    ringView             = [[UIImageView alloc] initWithFrame: ringRect];
    ringView.image       = [UIImage imageNamed:ringName];
    ringView.contentMode = UIViewContentModeScaleAspectFill;

    [self addSubview: ringView];
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    [self knobToIdle];
    ringView.alpha = 0.85;

    backgroundQueue = dispatch_queue_create("com.BinaryBlobs.Dpad", NULL);
 
    // Update owner...
    dispatch_async(backgroundQueue, ^(void) {
        [self dispatchDelegates];
    });
    
    return self;
}
//--------------------------------------------------------------------------------------------------------------

CGFloat AngleBetweenTwoPoints(CGPoint point1, CGPoint point2)
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    
    CGFloat rads  = atan2( dy, dx);     // Range: 0 to 2_PI radians
    CGFloat angle = fmodf(rads, (2 * M_PI) );
    
    return angle;
}

//--------------------------------------------------------------------------------------------------------------

CGFloat DistanceBetweenTwoPoints(CGPoint point1, CGPoint point2)
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    
    return sqrt( dx*dx + dy*dy );
}
//--------------------------------------------------------------------------------------------------------------

-(void) knobToIdle
{
    [UIView beginAnimations : @"Centering" context:nil];
    [UIView setAnimationDuration: 0.15];
    [UIView setAnimationBeginsFromCurrentState:FALSE];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(knobAtIdle)];
    
    knobView.center = ringView.center;
    knobView.alpha  = 0.55;
    
    [UIView commitAnimations];
}

//--------------------------------------------------------------------------------------------------------------

- (void)knobAtIdle
{    
    knobAngle = 0;
    knobPower = 0;

    [self updateDelegates];
}

//--------------------------------------------------------------------------------------------------------------

- (void)dispatchDelegates
{
    [self updateDelegates];    
    
    double   delayInSeconds = 0.01;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    // Call again...
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self dispatchDelegates];
        });
}
//--------------------------------------------------------------------------------------------------------------

- (void)updateDelegates
{
    if(delegate)
    {
        [delegate updateCoords: knobPosition];
        [delegate updatePower:  knobPower ];                      // normalized
        [delegate updateAngle:  RADIANS_TO_DEGREES(knobAngle) ];  // degrees
    }
}

//--------------------------------------------------------------------------------------------------------------

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint point  = [touch locationInView:touch.view];
    
    knobView.alpha = 1.0; // In Focus
    
    double radius = ringView.bounds.size.width/2;
    
    CGFloat distance = DistanceBetweenTwoPoints(ringView.center, point);
    CGFloat angle    = AngleBetweenTwoPoints(ringView.center,    point);
    
    if(distance > radius)
    {
        //inside the circle
        distance = radius;
    }
    
    CGFloat rounded = 0;
    CGFloat degrees = RADIANS_TO_DEGREES(angle);

    if(degrees < 0)
    {
        degrees += 360;
    }
    
    switch(mode)
    {
        case BB_DpadMode_8way:
        {            
            rounded = (CGFloat) ( ((int) degrees / 45) * 45);
            angle   = DEGREES_TO_RADIANS(rounded);            
        }
        break;
            
        case BB_DpadMode_4way:
        {
            rounded = (CGFloat) ( ((int) degrees / 90) * 90);
            angle   = DEGREES_TO_RADIANS(rounded);
        }
        break;
          
        case BB_DpadMode_Analog:
        default:
        break;

    }//SWITCH;

    point.x = ringView.center.x + distance * cos(angle);
    point.y = ringView.center.y + distance * sin(angle);
    
    distance = DistanceBetweenTwoPoints(ringView.center, point);
    angle    = AngleBetweenTwoPoints(ringView.center,    point);
   
    
    knobAngle    = angle;
    knobPower    = distance/radius;
    knobPosition = point;

    [self updateDelegates];
    
	knobView.center = point;
    
//    NSLog(@"   rounded = %0.2f  degrees = %f", rounded, degrees);
}

//--------------------------------------------------------------------------------------------------------------

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self touchesBegan:touches withEvent:event];
}

//--------------------------------------------------------------------------------------------------------------

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self knobToIdle];
}

//--------------------------------------------------------------------------------------------------------------

-(void) setMode: (BB_DpadMode) val
{
    mode = val;
    
    if(delegate)
    {
        [delegate updateMode: mode];
    }
}

////--------------------------------------------------------------------------------------------------------------

-(BB_DpadMode) mode
{
    return mode;
}
    
//--------------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
//--------------------------------------------------------------------------------------------------------------

@end

