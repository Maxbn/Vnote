//
//  PDFview.m
//  Pratice
//
//  Created by Maxime BENJAMIN on 8/17/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

# import "PDFview.h"

@implementation PDFview
@synthesize frameCount,frameScale,pageSize,frames,captions,timeCodes,assignements;


- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        captions = [[NSMutableArray alloc]init];
        
    }
    return self;
}

-(void)drawRect:(NSRect)rect{
    
    
    int marginX = 50;
    //    NSLog(@"%d",marginX);
    NSSize frameSize = NSMakeSize(1280/frameScale, 720/frameScale);
    
    
    [[NSColor whiteColor]set];
    NSRect startingRect = NSMakeRect(marginX, ((self.bounds.size.height)-frameSize.height)-marginX, frameSize.width, frameSize.height);
    
    
    NSRect rectArray [frameCount];
    rectArray [0] = startingRect;
    
    int i;
    NSRect oneRect = rectArray[0];
    
    for (i= 1; i < frameCount ; i++) {
        
        oneRect.origin.x += frameSize.width + marginX;
        
        if ( NSMaxX (oneRect) > NSMaxX ([self bounds]) )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y -= frameSize.height + 200;
        }
        if ( i == 6 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080;
        }else if ( i == 12 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*2;
        }else if ( i == 18 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*3;
        }
        
        
        rectArray[i] = oneRect;
        
    }
    
    //    Actually draw stuff
    [[NSColor blackColor] set];
    for ( i = 0; i < frameCount; i++) {
        NSFrameRectWithWidth ( rectArray[i], 2 );
        
        
        NSImage * image = [[NSImage alloc]initWithCGImage:(__bridge CGImageRef)(frames[i]) size:frameSize];
        
        
        
        [image setFlipped:YES];
        
        NSString *textToDraw = [[NSString alloc]initWithString:captions[i]];
        NSString *timeCodeToDraw = [[NSString alloc]initWithString:timeCodes[i]];
        NSString *assignementToDraw = [[NSString alloc]initWithString:assignements[i]];
        
        //    NSPoint startingPoint = NSMakePoint(rectArray[i].origin.x, (rectArray[i].origin.y - 35));
        
        CGRect captionFrame = CGRectMake(rectArray[i].origin.x + 120, (rectArray[i].origin.y -155 ), (1280/frameScale) - 120, 150);
        CGRect timeCodeFrame = CGRectMake(rectArray[i].origin.x , (rectArray[i].origin.y -155 ), 110 , 150);
        CGRect AssignementFrame = CGRectMake(rectArray[i].origin.x , (rectArray[i].origin.y -175 ), 110 , 150);

        
        
        
        
        
        //        sets the font
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle]mutableCopy];
        
        NSFont *font = [NSFont fontWithName:@"Arial" size:19];
        [style setAlignment:NSJustifiedTextAlignment];
        
        
        [attributes setObject:font forKey:NSFontAttributeName];
        [attributes setObject:style forKey:NSParagraphStyleAttributeName];
        
        
        
        
        //       [textToDraw drawAtPoint:startingPoint withAttributes:attributes];
        [textToDraw drawInRect:captionFrame withAttributes:attributes];
        [timeCodeToDraw drawInRect:timeCodeFrame withAttributes:attributes];
        [assignementToDraw drawInRect:AssignementFrame withAttributes:attributes];

        
        
        [image drawInRect: rectArray[i]
                 fromRect: NSZeroRect
                operation: NSCompositeSourceOver fraction: 1.0];
        
        
        
    }
    
    
}

-(BOOL)isFlipped{
    return NO;
}


@end
