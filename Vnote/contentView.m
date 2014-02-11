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
    
//    AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];

    
//    NSLog(@"Rising from the depth of the NIB");
    isFullScren = NO;
    
//     NSTrackingArea *trackingView= [[NSTrackingArea alloc]initWithRect:self.frame options:(NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow ) owner:self userInfo:nil];
//    
//    [self addTrackingArea:trackingView];
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
    
    AppDelegate *myApp = (AppDelegate *) [[NSApplication sharedApplication]delegate];
    
    unichar deleteKey = NSDeleteCharacter;
    if ([[theEvent characters]isEqualToString:@"i"]) {
    
        
//        NSScreen *myScreen = [NSScreen mainScreen];
//
//        
////        Maximizes the video
//        
//        if (myApp.selectedProject != nil && [myApp.myContentView isFullScren] == NO){
//            
//            [myApp.playerViewHolder removeFromSuperview];
//
//            [myApp.myContentView addSubview: myApp.playerViewHolder];
//            [myApp.playerViewHolder setFrame:myApp.window.frame];
//
//            [myApp.playerViewHolder setFrameOrigin:myScreen.frame.origin];
//            
//            [myApp.window setFrame:myScreen.frame display:YES animate:YES];
//            
//            myApp.myContentView.isFullScren = YES;
//    
//        }
//        
//        else if ([myApp.myContentView isFullScren] == YES){
//            
//            [myApp.playerViewHolder removeFromSuperview];
//            
//            [myApp.playerViewHolder setFrame:myApp.videoContainerView.frame];
//            
//            [myApp.playerViewHolder setFrameOrigin:myApp.videoContainerView.frame.origin];
//
//
//            
//            [myApp.videoContainerView addSubview:myApp.playerViewHolder];
//            
//            myApp.myContentView.isFullScren = NO;
//
//
//
//        }
//
//
      

        
    }
    
    else if ([[theEvent characters]isEqualToString:@" "]) {
        
        
        [myApp playVideo:nil];
        [myApp.taskEntry setStringValue:@""];
    }
    
    else if ([[theEvent characters]isEqualToString:@"\r"]) {
        
        NSLog(@"return has been hit");
        
        
        [myApp addTask:nil];
    }
    
    else if ([[theEvent characters]characterAtIndex:0] == NSDeleteCharacter) {
        
        NSLog(@"R has been hit");
        
        [myApp removeTask:nil];
        

        
//
//        [myApp addTask:nil];
    
    
    }
    
}

-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent{
    return NO;
}

//
//-(void)mouseMoved:(NSEvent *)theEvent{
//    
//   
//    NSLog(@"Mouse is moving from %@",self);
//}



@end
