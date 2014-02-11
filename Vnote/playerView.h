//
//  playerView.h
//  Vnote
//
//  Created by Maxime BENJAMIN on 1/15/14.
//  Copyright (c) 2014 Maxime BENJAMIN. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface playerView : NSView{
    
    NSTrackingArea *trackingView;
    
}

@property (strong)IBOutlet NSButton *fullScreenButton;

@property (strong,nonatomic)NSArray *filterArray;


@end
