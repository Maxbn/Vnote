//
//  projectButtonView.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 2/8/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "projectButtonView.h"

@implementation projectButtonView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        trackingView= [[NSTrackingArea alloc]initWithRect:super.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInActiveApp ) owner:self userInfo:nil];
        
        
        [self addTrackingArea:trackingView];
        
        
    }
    return self;
}

-(void)awakeFromNib{
    
    [[self window] makeFirstResponder:self];
    [[self window] setAcceptsMouseMovedEvents:YES];
    

}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    //// Color Declarations
    NSColor* fillColor = [NSColor colorWithCalibratedRed: 0.731 green: 0.769 blue: 0.823 alpha: 1];
    NSColor* strokeColor2 = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 0];
    NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 0.429];
    NSColor* color2 = [NSColor colorWithCalibratedRed: 0.851 green: 0.871 blue: 0.898 alpha: 1];
    
    //// Shadow Declarations
    NSShadow* shadow2 = [[NSShadow alloc] init];
    [shadow2 setShadowColor: strokeColor];
    [shadow2 setShadowOffset: NSMakeSize(-1.1, 0.1)];
    [shadow2 setShadowBlurRadius: 7];
    
    //// Rectangle 2 Drawing
    NSBezierPath* rectangle2Path = [NSBezierPath bezierPathWithRect: NSMakeRect(-58.5, -142.5, 804, 382)];
    [color2 setFill];
    [rectangle2Path fill];
    [strokeColor2 setStroke];
    [rectangle2Path setLineWidth: 1];
    [rectangle2Path stroke];
    
    
    //// Rectangle Drawing
    NSBezierPath* rectanglePath = [NSBezierPath bezierPathWithRect: NSMakeRect(0, -30, 684, 66)];
    [NSGraphicsContext saveGraphicsState];
    [shadow2 set];
    [fillColor setFill];
    [rectanglePath fill];
    [NSGraphicsContext restoreGraphicsState];
    
    [fillColor setStroke];
    [rectanglePath setLineWidth: 2.5];
    [rectanglePath stroke];
    
    

    
    



	
}

-(BOOL)acceptsFirstResponder{
    
    return YES;
}



-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent{
    
    return YES;
}


-(void)mouseMoved:(NSEvent *)theEvent{
    
//    AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];
    [[self animator] setAlphaValue:1];
    
    
    //    [myApp.playerControls setBackgroundFilters:filterArray];
    
    //    NSLog(@"Mouse is moving from %@",self);
}

-(void)mouseEntered:(NSEvent *)theEvent{
    
    [[self animator] setAlphaValue:1];

}


-(void)mouseExited:(NSEvent *)theEvent{
    
    [[self animator] setAlphaValue:0];

}

- (void)updateTrackingAreas {
    
    NSRect eyeBox;
    [self removeTrackingArea:trackingView];
    eyeBox = [self bounds];
    trackingView= [[NSTrackingArea alloc]initWithRect:super.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInActiveApp ) owner:self userInfo:nil];
    
    
    [self addTrackingArea:trackingView];
}

@end
