//
//  dragView.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 9/3/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import "dragView.h"
#import "AppDelegate.h"

@implementation dragView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSURLPboardType]];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

#pragma mark Drag and Drop

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask])
        == NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they
        //are offering
        return NSDragOperationGeneric;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have
        //to tell them we aren't interested
        return NSDragOperationNone;
    }
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *paste = [sender draggingPasteboard];
    //gets the dragging-specific pasteboard from the sender
    NSArray *types = [NSArray arrayWithObject:NSURLPboardType];
    //a list of types that we can accept
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
    
    if (nil == carriedData)
    {
        //the operation failed for some reason
        NSRunAlertPanel(@"Paste Error", @"Sorry, but the past operation failed",
                        nil, nil, nil);
        return NO;
    }
    else
    {
        //the pasteboard was able to give us some meaningful data
        if ([desiredType isEqualToString:NSURLPboardType])
        {
            
            
            NSArray *urls = [paste readObjectsForClasses:@[[NSURL class]] options:nil];
//            NSLog(@"URLs are: %@", urls);
            
            for (NSURL* fileUrl in urls){
                
                [(AppDelegate*)[[NSApplication sharedApplication] delegate] dragNewProject:fileUrl];
            }
            
        }
        
        
        else
        {
            //this can't happen
            NSAssert(NO, @"This can't happen");
            return NO;
        }
    }
    return YES;
}
@end
