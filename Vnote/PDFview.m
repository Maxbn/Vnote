//
//  PDFview.m
//  Pratice
//
//  Created by Maxime BENJAMIN on 8/17/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

# import "PDFview.h"

@implementation PDFview
@synthesize frameCount,frameScale,pageSize,frames,captions,timeCodes,assignements,frameNumber;


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

        } else if ( i == 12 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*2;
        }else if ( i == 18 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*3;
        }else if ( i == 24 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*4;
        }else if ( i == 30 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*5;
        }else if ( i == 36 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*6;
        }else if ( i == 42 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*7;
        }else if ( i == 54 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*8;
        }else if ( i == 60 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*9;
        }else if ( i == 66 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*10;
        }else if ( i == 72 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*11;
        }else if ( i == 78 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*12;
        }else if ( i == 84 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*13;
        }else if ( i == 90 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*14;
        }else if ( i == 96 )
        {
            oneRect.origin.x = startingRect.origin.x;
            oneRect.origin.y = startingRect.origin.y - 1080*15;
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
//        NSString *frameNumberToDray = [[NSString alloc] initWithString:i];
        
        //    NSPoint startingPoint = NSMakePoint(rectArray[i].origin.x, (rectArray[i].origin.y - 35));
        
        CGRect captionFrame = CGRectMake(rectArray[i].origin.x + 120, (rectArray[i].origin.y -162 ), (1280/frameScale) - 120, 150);
        CGRect timeCodeFrame = CGRectMake(rectArray[i].origin.x , (rectArray[i].origin.y -162 ), 110 , 150);
        CGRect AssignementFrame = CGRectMake(rectArray[i].origin.x , (rectArray[i].origin.y -175 ), 110 , 150);
        
//         CGRect frameNumber = CGRectMake(rectArray[i].origin.x , (rectArray[i].origin.y -180 ), 110 , 150);
//        
        
        
        
        
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

-(BOOL)acceptsFirstResponder{
    return  NO;
}


@end
