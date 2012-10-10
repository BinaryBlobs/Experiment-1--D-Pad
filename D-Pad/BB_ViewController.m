//
//  BB_ViewController.m
//  D-Pad
//
//  Created by Hugh on 10/8/12.
//  Copyright (c) 2012 Binary Blobs. All rights reserved.
//

#import "BB_ViewController.h"

#import "BB_DpadView.h"


@interface BB_ViewController ()
{
    UIImageView *knobView2;
    UIImageView *ringView2;

    CGPoint ptStart;
}
@end


@implementation BB_ViewController

@synthesize only_4way;
@synthesize only_8way;

//--------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    dPad = [[BB_DpadView alloc] initWithFrame: CGRectMake(20, 20, 80, 80)];
  
    [dPad setMode: BB_DpadViewMode8way];
    
    [self.view addSubview: dPad];
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}
//--------------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//--------------------------------------------------------------------------------------------------------------

CGFloat AngleBetweenTwoPoints(CGPoint point1, CGPoint point2)
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
      
    CGFloat rads  = atan2( dy, dx); // Range: 0 to 2*pi radians
    CGFloat angle = fmodf(rads, (2*M_PI) );// + M_PI/2;  // +PI/2 to offset (always) to 12 O'Clock
    
    return angle;
};

//--------------------------------------------------------------------------------------------------------------

CGFloat DistanceBetweenTwoPoints(CGPoint point1,CGPoint point2)
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
    
   // CGRect rcRing = ringView.bounds;
    double radius = ringView.bounds.size.width/2;
    
    CGFloat distance = DistanceBetweenTwoPoints(ringView.center, point);
    CGFloat angle    = AngleBetweenTwoPoints(ringView.center,    point);
    
    if(distance > radius)
    {
        //inside the circle        
        point.x = ringView.center.x + radius * cos(angle);
        point.y = ringView.center.y + radius * sin(angle);
    }
        
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
