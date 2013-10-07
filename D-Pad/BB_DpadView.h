//
//  BB_DpadView.h
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

#import <UIKit/UIKit.h>


#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(degrees) ((degrees) / 180.0  * M_PI)

typedef NS_ENUM(NSInteger, BB_DpadMode)
{
    BB_DpadMode_8way,
    BB_DpadMode_4way,
    BB_DpadMode_Analog,
    
    BB_DpadMode_COUNT
};

//--------------------------------------------------------------------------------------------------------------

@protocol BB_DpadDelegate <NSObject>
@required
- (void) updateMode:(BB_DpadMode)  mode;

- (void) updateAngle:(CGFloat)  degrees;  // degrees
- (void) updatePower:(CGFloat)  power;    // normalized
- (void) updateCoords:(CGPoint) point;    // normalized
@end

//--------------------------------------------------------------------------------------------------------------

@interface BB_DpadView : UIView
{
    id<BB_DpadDelegate>  delegate;
}

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic) id delegate;

@property BB_DpadMode     mode;

@property NSString       *ringName;
@property NSString       *knobName;


//--------------------------------------------------------------------------------------------------------------

@end


