//
//  PDFview.h
//  Pratice
//
//  Created by Maxime BENJAMIN on 8/17/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFview : NSView{
        
    int frameCount;
    CGFloat frameScale;
    NSSize pageSize;
    NSMutableArray *frames;
    NSMutableArray *captions;
    NSMutableArray *timeCodes;

    
}

@property int frameCount;
@property CGFloat frameScale;
@property NSSize pageSize;
@property NSMutableArray *frames;
@property NSMutableArray *captions;
@property NSMutableArray *timeCodes;
@property NSMutableArray *assignements;
@property NSMutableArray *frameNumber;


@end
