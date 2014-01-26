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


        
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    if ([self isInFullScreenMode]) {
        [[NSColor blackColor]setFill];
         NSRectFill(dirtyRect);
         [super drawRect:dirtyRect];
    }
}


-(BOOL)acceptsFirstResponder{
    
    return YES;
}



-(void)keyDown:(NSEvent *)theEvent{
    if ([[theEvent characters]isEqualToString:@"e"]) {
       
        [self exitFullScreenModeWithOptions:Nil];
}
        else if ([[theEvent characters]isEqualToString:@" "]) {
           AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];

            [myApp playVideo:nil];
    }
    
}


//Exits full screen




@end
