//
//  BB_DpadView.h
//  D-Pad
//
//  Created by Hugh on 10/9/12.
//  Copyright (c) 2012 Binary Blobs. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, BB_DpadViewMode)
{
    BB_DpadViewMode8way,
    BB_DpadViewMode4way,
    BB_DpadViewModeAnalog
};


@interface BB_DpadView : UIView
{
}

- (id)initWithFrame:(CGRect)frame;

@property BB_DpadViewMode mode;

@property NSString *ringName;
@property NSString *knobName;


@end


