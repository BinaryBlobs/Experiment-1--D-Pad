//
//  BB_ViewController.m
//  D-Pad
//
//  Created by Hugh on 10/8/12.
//  Copyright (c) 2012 Binary Blobs. All rights reserved.
//

#import "BB_ViewController.h"

@interface BB_ViewController ()


@end

@implementation BB_ViewController


//--------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGPoint middle = [self.view center];
    
    [knobView setCenter: middle];
    [ringView setCenter: middle];    
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
    
  //  CGFloat angle = atan(dy / dx);// * 180 / M_PI;
  
    CGFloat rads  = atan2( dy, dx); // Range: 0 to 2*pi radians
    CGFloat angle = fmodf(rads, (2*M_PI) );// + M_PI/2;  // +PI/2 to offset (always) to 12 O'Clock
    
    return angle;
};

//--------------------------------------------------------------------------------------------------------------

CGFloat DistanceBetweenTwoPoints(CGPoint point1,CGPoint point2)
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    
    return sqrt(dx*dx + dy*dy );
};

//--------------------------------------------------------------------------------------------------------------

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint point = [touch locationInView:touch.view];
    
    
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

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint ptEnd = [touch locationInView:self.view];
////    CGPoint delta = ptStart - ptEnd;
////    
////    CGPoint ptMove = knobView.center - delta;
//    
//    CGPoint delta,ptMove;
//    
//    delta  = CGPointMake( ptStart.x - ptEnd.x,         ptStart.y - ptEnd.y);
//    ptMove = CGPointMake( knobView.center.x - delta.x, knobView.center.y - delta.y);
//        
//    [knobView setCenter: ptMove];
//    
////    knobView.center.x = ptMove.x - delta.x;
////    knobView.center.y = ptMove.y - delta.y;
//    
//    ptStart = ptEnd;
//}
////--------------------------------------------------------------------------------------------------------------
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint     pt = [touch locationInView:self];
//    
//    ptStart = pt;
//}

//--------------------------------------------------------------------------------------------------------------
@end
