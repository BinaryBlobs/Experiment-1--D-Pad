//
//  D_PadTests.m
//  D-PadTests
//
//  Created by Binary Blobs on 10/8/12.
//  Copyright (c) 2012 Binary Blobs. All rights reserved.
//
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

#import "D_PadTests.h"


@implementation D_PadTests

@synthesize dPad;

//--------------------------------------------------------------------------------------------------------------

- (void)setUp
{
    [super setUp];
    
    dPad = [[BB_DpadView alloc] initWithFrame: CGRectMake(20,200, 80,80)];

    // Set-up code here.
}
//--------------------------------------------------------------------------------------------------------------

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}
//--------------------------------------------------------------------------------------------------------------

- (void)testExample
{
    [dPad setMode:     BB_DpadMode_4way];
    [dPad setDelegate: self];
    
    STFail(@"Unit tests are not implemented yet in D-PadTests");
}
//--------------------------------------------------------------------------------------------------------------

@end
