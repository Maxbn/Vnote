//
//  forwardButton.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 2/9/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "forwardButton.h"

@implementation forwardButton


- (void)drawBezelWithFrame:(NSRect)frame
                    inView:(NSView *)controlView
{

    //// Color Declarations
    NSColor* fillColor = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0.458];
    NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Group
    {
        //// Bezier Drawing
        NSBezierPath* bezierPath = [NSBezierPath bezierPath];
        [bezierPath moveToPoint: NSMakePoint(5.75, 19.17)];
        [bezierPath curveToPoint: NSMakePoint(5.75, 1.25) controlPoint1: NSMakePoint(5.75, 19.54) controlPoint2: NSMakePoint(5.75, 1.25)];
        [bezierPath lineToPoint: NSMakePoint(21.58, 9.66)];
        [bezierPath curveToPoint: NSMakePoint(5.75, 19.17) controlPoint1: NSMakePoint(21.58, 9.66) controlPoint2: NSMakePoint(5.75, 18.81)];
        [bezierPath closePath];
        [fillColor setFill];
        [bezierPath fill];
        [strokeColor setStroke];
        [bezierPath setLineWidth: 1];
        [bezierPath stroke];
        
        
        //// Bezier 2 Drawing
        NSBezierPath* bezier2Path = [NSBezierPath bezierPath];
        [bezier2Path moveToPoint: NSMakePoint(2, 19.17)];
        [bezier2Path lineToPoint: NSMakePoint(2, 0.42)];
        [fillColor setFill];
        [bezier2Path fill];
        [strokeColor setStroke];
        [bezier2Path setLineWidth: 3];
        [bezier2Path stroke];
    }
    
    


    
}

@end
