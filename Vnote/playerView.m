//
//  playerView.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 1/15/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "playerView.h"
#import "AppDelegate.h"

@implementation playerView
@synthesize filterArray;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
//        AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];

        trackingView= [[NSTrackingArea alloc]initWithRect:super.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInActiveApp ) owner:self userInfo:nil];
        
        
        [self addTrackingArea:trackingView];
   
        
        
    }
    return self;
}

-(void)awakeFromNib{
    
    [[self window] makeFirstResponder:self];
    [[self window] setAcceptsMouseMovedEvents:YES];
    
    CIFilter *darkenFilter= [CIFilter filterWithName:@"CIExposureAdjust"];
    [darkenFilter setValue:[NSNumber numberWithFloat:-3.5] forKey:@"inputEV"];
    
    filterArray = [NSArray arrayWithObject:darkenFilter];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    [[NSColor blackColor]setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
    
//    if ([self isInFullScreenMode]) {
//       
//    }
}


-(BOOL)acceptsFirstResponder{
    
    return YES;
}



-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent{
    
    return YES;
}

-(void)keyDown:(NSEvent *)theEvent{
    
    [super keyDown:theEvent];
    
}




    
-(void)mouseMoved:(NSEvent *)theEvent{
    
    AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];
//    [myApp animateFilterIn];
    [[myApp.playerControls animator] setAlphaValue:1];
    
    
//    [myApp.playerControls setBackgroundFilters:filterArray];
    
//    NSLog(@"Mouse is moving from %@",self);
}

-(void)mouseEntered:(NSEvent *)theEvent{
    
}


-(void)mouseExited:(NSEvent *)theEvent{
    
    AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];
    
    
  

    [[myApp.playerControls animator] setAlphaValue:0];
//    [[myApp.playerControls animator] ];


    
//    [[myApp.playerControls animator ] setBackgroundFilters:nil];
    
}

- (void)updateTrackingAreas {
    
    NSRect eyeBox;
    [self removeTrackingArea:trackingView];
    eyeBox = [self bounds];
    trackingView= [[NSTrackingArea alloc]initWithRect:super.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInActiveApp ) owner:self userInfo:nil];
    
    
    [self addTrackingArea:trackingView];

}





@end
