//
//  Task.h
//  Pratice
//
//  Created by Maxime BENJAMIN on 8/10/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Task : NSObject<NSCoding>
{
    NSString *taskName;
    NSString *formatedTime;
    NSInteger taskTime;
    CMTime timeCode;
    BOOL done;
}

-(NSString *)taskName;
@property (strong,nonatomic) NSString *taskName;
@property NSInteger taskTime;
@property CMTime timeCode;
@property NSString *formatedTime;
@property NSButton *checked;
@property BOOL done;
@property NSString *assignedTo;




-(void)setformatedTime:(NSUInteger)seconds;


@end
