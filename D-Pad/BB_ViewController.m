//
//  BB_ViewController.m
//  D-Pad
//
//  Created by Binary Blobs on 10/8/12.
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

#import "BB_ViewController.h"


@interface BB_ViewController ()
{
    CGFloat knobAngle;
    CGFloat knobPower;
}
@end


@implementation BB_ViewController

//--------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    dPad = [[BB_DpadView alloc] initWithFrame: CGRectMake(20,200, 80,80)];
  
    [dPad setMode:     BB_DpadMode_Analog];
    [dPad setDelegate: self];
    
    [self.view addSubview: dPad];
}

#pragma mark GUI Updates...
//--------------------------------------------------------------------------------------------------------------

- (void) updateBall
{
    CGPoint ptBall = ballView.center;
    
    float dx = knobPower * cos( DEGREES_TO_RADIANS(knobAngle) );
    float dy = knobPower * sin( DEGREES_TO_RADIANS(knobAngle) );
    
    ptBall.x += dx;
    ptBall.y += dy;

    ballView.center = ptBall;
}

//--------------------------------------------------------------------------------------------------------------

- (void) updateCoords:(CGPoint) point   // normalized
{
    //    NSLog(@" updateCoords:  %2.1f, %2.1f", point.x, point.y);
    
    xyValue.text = [NSString stringWithFormat: @"%2.1f, %2.1f", point.x, point.y];
}

//--------------------------------------------------------------------------------------------------------------

// Mode Button Pressed...
//
- (IBAction)buttonPressed:(id)sender
{
    BB_DpadMode mode = [dPad mode];
    
    mode++;
    
    if(mode == BB_DpadMode_COUNT)
    {
        mode = 0;
    }
    
    [dPad setMode: mode];
}

#pragma mark <BB_DpadDelegate> Delegate Methods
//--------------------------------------------------------------------------------------------------------------

- (void) updateMode: (BB_DpadMode)  mode
{
    switch(mode)
    {
        case BB_DpadMode_8way:
            [modeButton setTitle: @"8 Way"  forState: UIControlStateNormal];
            break;
            
        case BB_DpadMode_4way:
            [modeButton setTitle: @"4 Way"  forState: UIControlStateNormal];
            break;
            
        case BB_DpadMode_Analog:
            [modeButton setTitle: @"Analog" forState: UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
//--------------------------------------------------------------------------------------------------------------

- (void) updateAngle:(CGFloat) degrees
{
    //    NSLog(@" updateAngle:  %f  degrees", degrees);
    
    knobAngle = degrees;
    
    angleValue.text = [NSString stringWithFormat: @"%3.1f ˚", degrees];
    
    [self updateBall];
}
//--------------------------------------------------------------------------------------------------------------

- (void) updatePower:(CGFloat) power    // normalized [0.0 <-> 1.0]
{
    //NSLog(@" updatePower:  %f  degrees", power);
    
    knobPower = power;
    
    powerValue.text = [NSString stringWithFormat: @"%2.2f", power];
}
//--------------------------------------------------------------------------------------------------------------

#pragma mark Clean Up

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//--------------------------------------------------------------------------------------------------------------

- (void)viewDidUnload
{
    modeButton = nil;
    xyValue    = nil;
    angleValue = nil;
    powerValue = nil;
    modeButton = nil;
    ballView   = nil;
    
    [super viewDidUnload];
}

//--------------------------------------------------------------------------------------------------------------

@end
