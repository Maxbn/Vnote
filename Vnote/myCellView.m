//
//  myCellView.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 10/20/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import "myCellView.h"

@implementation myCellView


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void)textDidEndEditing:(NSNotification *)aNotification{
    
    
}

- (BOOL)control:(NSControl*)control textShouldBeginEditing:(NSText *)fieldEditor {
    self.editing = YES;
    return YES;
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
    if (self.editing) {
        self.editing = NO;
//        [self mergeFromSource:self.category toDestination:self.categoryLabel.stringValue];
    }
    return YES;
}

@end
