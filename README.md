Experiment 1 - D-Pad
===================

A UIKIt based D-Pad controller developed as a proof of concept.

The D-Pad is added to the current view -

 

   dPad = [[BB_DpadView alloc] initWithFrame: CGRectMake(20,200, 80,80)];

   [dPad setMode:     BB_DpadMode_Analog];
   [dPad setDelegate: self];

There are 2 separate UIImageView‘s added programatically.  These display the “ring” and the “knob” of the D-Pad.

Note that the superview of the D-Pad is it’s delegate.



@protocol BB_DpadDelegate <NSObject>

  @required

  - (void) updateMode:(BB_DpadMode)  mode;

  - (void) updateAngle:(CGFloat)  degrees;  // degrees

  - (void) updatePower:(CGFloat)  power;    // normalized

  - (void) updateCoords:(CGPoint) point;    // normalized

  @end

The protocol is pretty easy.

Updates of Angle and Power – and optionally coordinates of the “knob”
position in a ‘notional’ Unit Circle.
