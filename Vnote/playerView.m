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

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        NSLog(@"Player View Initiated");
        
//        AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];

   
        
        
    }
    return self;
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
    
    NSLog(@"Mouse is moving");
}


    




@end
