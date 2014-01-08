//
//  myTableView.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 10/12/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import "myTableView.h"

@implementation myTableView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}


- (void)textDidEndEditing:(NSNotification *)aNotification{
    
//    [super textDidEndEditing:aNotification];
//    NSLog(@"YALAAAAAAA");
}

@end
