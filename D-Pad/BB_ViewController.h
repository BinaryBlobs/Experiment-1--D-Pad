//
//  BB_ViewController.h
//  D-Pad
//
//  Created by Hugh on 10/8/12.
//  Copyright (c) 2012 Binary Blobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BB_ViewController : UIViewController
{
    IBOutlet UIImageView *knobView;
    IBOutlet UIImageView *ringView;

    CGPoint ptStart;
}

@end
