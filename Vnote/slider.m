//
//  slider.m
//  Vnote
//
//  Created by Maxime BENJAMIN on 2/8/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import "slider.h"

@implementation slider

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
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(void)setNeedsDisplayInRect:(NSRect)invalidRect{
    [super setNeedsDisplayInRect:[self bounds]];
}

@end
