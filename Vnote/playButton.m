//
//  playButton.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 2/8/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "playButton.h"

@implementation playButton




- (void)drawBezelWithFrame:(NSRect)frame
                    inView:(NSView *)controlView
{

    //// Color Declarations

    
    if (self.state == NSOnState) {
        //// Color Declarations
        NSColor* fillColor = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0.458];
        NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
        
        //// Bezier Drawing
        NSBezierPath* bezierPath = [NSBezierPath bezierPath];
        [bezierPath moveToPoint: NSMakePoint(0.5, 33.5)];
        [bezierPath curveToPoint: NSMakePoint(0.5, 0.5) controlPoint1: NSMakePoint(0.5, 34.18) controlPoint2: NSMakePoint(0.5, 0.5)];
        [bezierPath lineToPoint: NSMakePoint(30, 15.99)];
        [bezierPath curveToPoint: NSMakePoint(0.5, 33.5) controlPoint1: NSMakePoint(30, 15.99) controlPoint2: NSMakePoint(0.5, 32.83)];
        [bezierPath closePath];
        [fillColor setFill];
        [bezierPath fill];
        [strokeColor setStroke];
        [bezierPath setLineWidth: 1];
        [bezierPath stroke];
        
        

        
        
    }else if (self.state == NSOffState){
        
        //// Color Declarations
        NSColor* fillColor = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0.458];
        NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
        
        //// Group
        {
            //// Rectangle Drawing
            NSBezierPath* rectanglePath = [NSBezierPath bezierPathWithRect: NSMakeRect(0.5, 0.5, 8, 29)];
            [fillColor setFill];
            [rectanglePath fill];
            [strokeColor setStroke];
            [rectanglePath setLineWidth: 1];
            [rectanglePath stroke];
            
            
            //// Rectangle 2 Drawing
            NSBezierPath* rectangle2Path = [NSBezierPath bezierPathWithRect: NSMakeRect(15.5, 0.5, 8, 29)];
            [fillColor setFill];
            [rectangle2Path fill];
            [strokeColor setStroke];
            [rectangle2Path setLineWidth: 1];
            [rectangle2Path stroke];
        }
        
        

        

        

    }
    
    
;
    

    
     
}

@end
