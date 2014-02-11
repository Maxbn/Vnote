//
//  mailButton.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 2/9/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "mailButton.h"

@implementation mailButton


- (void)drawBezelWithFrame:(NSRect)frame
                    inView:(NSView *)controlView
{

    
    //// Color Declarations
    NSColor* fillColor = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0];
    NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
    NSColor* color2 = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 0];
    NSColor* color5 = [NSColor colorWithCalibratedRed: 0.728 green: 0.768 blue: 0.823 alpha: 1];
    
    //// Group
    {
        //// Bezier 3 Drawing
        NSBezierPath* bezier3Path = [NSBezierPath bezierPath];
        [bezier3Path moveToPoint: NSMakePoint(9.38, 8.59)];
        [bezier3Path curveToPoint: NSMakePoint(18.38, 15.98) controlPoint1: NSMakePoint(9.38, 8.59) controlPoint2: NSMakePoint(14.54, 12.08)];
        [bezier3Path curveToPoint: NSMakePoint(26.62, 8.59) controlPoint1: NSMakePoint(20.77, 13.53) controlPoint2: NSMakePoint(26.62, 8.59)];
        [bezier3Path lineToPoint: NSMakePoint(9.38, 8.59)];
        [bezier3Path closePath];
        [color5 setFill];
        [bezier3Path fill];
        [fillColor setStroke];
        [bezier3Path setLineWidth: 0.5];
        [bezier3Path stroke];
        
        
        //// Rectangle Drawing
        NSBezierPath* rectanglePath = [NSBezierPath bezierPathWithRect: NSMakeRect(9, 8.5, 18, 14)];
        [fillColor setFill];
        [rectanglePath fill];
        [strokeColor setStroke];
        [rectanglePath setLineWidth: 1];
        [rectanglePath stroke];
        
        
        //// Bezier 2 Drawing
        NSBezierPath* bezier2Path = [NSBezierPath bezierPath];
        [bezier2Path moveToPoint: NSMakePoint(9.11, 8.59)];
        [bezier2Path curveToPoint: NSMakePoint(18.38, 15.98) controlPoint1: NSMakePoint(9.11, 8.59) controlPoint2: NSMakePoint(9.15, 8.79)];
        [bezier2Path curveToPoint: NSMakePoint(29.74, 6.34) controlPoint1: NSMakePoint(29.27, 6.73) controlPoint2: NSMakePoint(29.74, 6.34)];
        [bezier2Path setLineCapStyle: NSRoundLineCapStyle];
        [bezier2Path setLineJoinStyle: NSRoundLineJoinStyle];
        [color2 setFill];
        [bezier2Path fill];
        [strokeColor setStroke];
        [bezier2Path setLineWidth: 1];
        [bezier2Path stroke];
        
        
        //// Bezier Drawing
        NSBezierPath* bezierPath = [NSBezierPath bezierPath];
        [bezierPath moveToPoint: NSMakePoint(25.12, 6.37)];
        [bezierPath lineToPoint: NSMakePoint(29.74, 6.34)];
        [bezierPath lineToPoint: NSMakePoint(29.74, 10.42)];
        [strokeColor setStroke];
        [bezierPath setLineWidth: 1];
        [bezierPath stroke];
    }
    
    



    
    
}

@end
