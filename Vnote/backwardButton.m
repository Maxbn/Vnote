//
//  backwardButton.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 2/9/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "backwardButton.h"

@implementation backwardButton


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
        [bezierPath moveToPoint: NSMakePoint(18.06, 20.13)];
        [bezierPath curveToPoint: NSMakePoint(18.06, 1.31) controlPoint1: NSMakePoint(18.06, 20.52) controlPoint2: NSMakePoint(18.06, 1.31)];
        [bezierPath lineToPoint: NSMakePoint(1.44, 10.15)];
        [bezierPath curveToPoint: NSMakePoint(18.06, 20.13) controlPoint1: NSMakePoint(1.44, 10.15) controlPoint2: NSMakePoint(18.06, 19.75)];
        [bezierPath closePath];
        [fillColor setFill];
        [bezierPath fill];
        [strokeColor setStroke];
        [bezierPath setLineWidth: 1];
        [bezierPath stroke];
        
        
        //// Bezier 2 Drawing
        NSBezierPath* bezier2Path = [NSBezierPath bezierPath];
        [bezier2Path moveToPoint: NSMakePoint(22, 20.12)];
        [bezier2Path lineToPoint: NSMakePoint(22, 0.44)];
        [fillColor setFill];
        [bezier2Path fill];
        [strokeColor setStroke];
        [bezier2Path setLineWidth: 3];
        [bezier2Path stroke];
    }
    
    


    
}


@end
