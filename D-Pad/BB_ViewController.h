//
//  BB_ViewController.h
//  D-Pad
//
//  Created by Hugh on 10/8/12.
//  Copyright (c) 2012 Binary Blobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BB_DpadView;

@interface BB_ViewController : UIViewController
{
    IBOutlet UIImageView *knobView;
    IBOutlet UIImageView *ringView;
    
    BB_DpadView *dPad;
    
}

@property BOOL only_4way;
@property BOOL only_8way;

@end
