//
//  contentView.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 1/27/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "contentView.h"
#import "AppDelegate.h"

@implementation contentView
@synthesize isFullScren;

-(void)awakeFromNib{
    
    NSLog(@"Rising from the depth of the NIB");
    isFullScren = NO;
}



- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSLog(@"content view initialized");

    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(BOOL)acceptsFirstResponder{
    
    return YES;
}

-(void)keyDown:(NSEvent *)theEvent{
    if ([[theEvent characters]isEqualToString:@"i"]) {
        
        
        AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];
        NSScreen *myScreen = [NSScreen mainScreen];

        
//        Maximizes the video
        
        if (myApp.selectedProject != nil && [myApp.myContentView isFullScren] == NO){
            
            [myApp.playerViewHolder removeFromSuperview];

            [myApp.myContentView addSubview: myApp.playerViewHolder];
            [myApp.playerViewHolder setFrame:myApp.window.frame];

            [myApp.playerViewHolder setFrameOrigin:myScreen.frame.origin];
            
            [myApp.window setFrame:myScreen.frame display:YES animate:YES];
            
            myApp.myContentView.isFullScren = YES;
    
        }
        
        else if ([myApp.myContentView isFullScren] == YES){
            
            [myApp.playerViewHolder removeFromSuperview];
            
            [myApp.playerViewHolder setFrame:myApp.videoContainerView.frame];
            
            [myApp.playerViewHolder setFrameOrigin:myApp.videoContainerView.frame.origin];


            
            [myApp.videoContainerView addSubview:myApp.playerViewHolder];
            
            myApp.myContentView.isFullScren = NO;



        }


      

        
    }
    
    else if ([[theEvent characters]isEqualToString:@" "]) {
        
        AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];
        
        [myApp playVideo:nil];
        [myApp.taskEntry setStringValue:@""];
    }
    
    else if ([[theEvent characters]isEqualToString:@"\r"]) {
        
        NSLog(@"return has been hit");
        
        AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];
        
        [myApp addTask:nil];
    }
    
    
}



@end
