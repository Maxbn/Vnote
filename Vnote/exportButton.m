//
//  exportButton.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 2/9/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "exportButton.h"

@implementation exportButton


- (void)drawBezelWithFrame:(NSRect)frame
                    inView:(NSView *)controlView
{
    
    
    //// Color Declarations
    NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Group 3
    {
        //// Group
        {
            //// Bezier Drawing
            NSBezierPath* bezierPath = [NSBezierPath bezierPath];
            [bezierPath moveToPoint: NSMakePoint(8.24, 5.29)];
            [bezierPath curveToPoint: NSMakePoint(17.64, 9.16) controlPoint1: NSMakePoint(8.24, 5.29) controlPoint2: NSMakePoint(16.01, 4.2)];
            [bezierPath setLineJoinStyle: NSRoundLineJoinStyle];
            [strokeColor setStroke];
            [bezierPath setLineWidth: 1];
            [bezierPath stroke];
            
            
            //// Bezier 2 Drawing
            NSBezierPath* bezier2Path = [NSBezierPath bezierPath];
            [bezier2Path moveToPoint: NSMakePoint(8.24, 5.29)];
            [bezier2Path lineToPoint: NSMakePoint(8.24, 18.82)];
            [bezier2Path curveToPoint: NSMakePoint(17.64, 20.76) controlPoint1: NSMakePoint(8.24, 18.82) controlPoint2: NSMakePoint(11.48, 18.77)];
            [strokeColor setStroke];
            [bezier2Path setLineWidth: 1];
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            NSBezierPath* bezier3Path = [NSBezierPath bezierPath];
            [bezier3Path moveToPoint: NSMakePoint(17.64, 9.16)];
            [bezier3Path lineToPoint: NSMakePoint(17.76, 20.76)];
            [strokeColor setStroke];
            [bezier3Path setLineWidth: 0.5];
            [bezier3Path stroke];
        }
        
        
        //// Group 2
        {
            //// Bezier 4 Drawing
            NSBezierPath* bezier4Path = [NSBezierPath bezierPath];
            [bezier4Path moveToPoint: NSMakePoint(27.76, 5.29)];
            [bezier4Path curveToPoint: NSMakePoint(18.36, 9.16) controlPoint1: NSMakePoint(27.76, 5.29) controlPoint2: NSMakePoint(19.99, 4.2)];
            [bezier4Path setLineJoinStyle: NSRoundLineJoinStyle];
            [strokeColor setStroke];
            [bezier4Path setLineWidth: 1];
            [bezier4Path stroke];
            
            
            //// Bezier 5 Drawing
            NSBezierPath* bezier5Path = [NSBezierPath bezierPath];
            [bezier5Path moveToPoint: NSMakePoint(27.76, 5.29)];
            [bezier5Path lineToPoint: NSMakePoint(27.76, 18.82)];
            [bezier5Path curveToPoint: NSMakePoint(18.36, 20.76) controlPoint1: NSMakePoint(27.76, 18.82) controlPoint2: NSMakePoint(24.52, 18.77)];
            [strokeColor setStroke];
            [bezier5Path setLineWidth: 1];
            [bezier5Path stroke];
            
            
            //// Bezier 6 Drawing
            NSBezierPath* bezier6Path = [NSBezierPath bezierPath];
            [bezier6Path moveToPoint: NSMakePoint(18.36, 9.16)];
            [bezier6Path lineToPoint: NSMakePoint(18.24, 20.76)];
            [strokeColor setStroke];
            [bezier6Path setLineWidth: 0.5];
            [bezier6Path stroke];
        }
    }
    
    

    

    
    
    
}


@end
