//
//  Task.m
//  Pratice
//
//  Created by Maxime BENJAMIN on 8/10/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import "Task.h"

@implementation Task
@synthesize taskName,timeCode,taskTime,formatedTime,checked,done,assignedTo;

-(id)init{
    self = [super init];
    
    if (self) {
       
        done = NO;
        
    }
    return self;
}

-(NSString *)taskName{
    return taskName;
}

- (void) encodeWithCoder: (NSCoder *)coder{
    
    [coder encodeObject:[self taskName] forKey:@"taskname"];
    [coder encodeCMTime:[self timeCode] forKey:@"timecode"];
    [coder encodeInteger:[self taskTime] forKey:@"tasktime"];
    [coder encodeObject:[self formatedTime] forKey:@"formatedtime"];
    [coder encodeObject:[self checked] forKey:@"checkbox"];
    [coder encodeBool:[self done] forKey:@"done"];
    [coder encodeObject:[self assignedTo] forKey:@"assignedTo"];



    
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        [self setTaskName: [coder decodeObjectForKey:@"taskname"]];
        [self setTimeCode: [coder decodeCMTimeForKey:@"timecode"]];
        [self setTaskTime: [coder decodeIntegerForKey:@"tasktime"]];
        [self setFormatedTime:[coder decodeObjectForKey:@"formatedtime"]];
        [self setChecked: [coder decodeObjectForKey:@"checkbox"]];
        [self setDone:[coder decodeBoolForKey:@"done"]];
        [self setAssignedTo:[coder decodeObjectForKey:@"assignedTo"]];

        
    }
    return self;
}

-(void)setformatedTime:(NSUInteger)seconds{
    
    NSString *minutes;
    NSString *secondes;
    NSString *time;
    
//    Sets the minute String
    if (seconds < 60 ) {
        minutes = @"0";
    }else if (seconds > 60 && seconds < 120 ){
        minutes = @"1";
    }else if (seconds > 120 && seconds < 180 ){
        minutes = @"2";
    }else if (seconds > 180 && seconds < 240 ){
        minutes = @"3";
    }else if (seconds > 300 && seconds < 360 ){
        minutes = @"4";
    }
    
//    Sets the seconds String
    NSUInteger remainingSeconds;
    NSNumber *number;
    
    if (seconds > 60 ) {
        remainingSeconds = seconds - 60;
        number = [NSNumber numberWithUnsignedInteger:remainingSeconds];
    }else{
        number = [NSNumber numberWithUnsignedInteger:seconds];

    }
    
    secondes = number.stringValue;
    
    
    NSString *addMinute = [minutes stringByAppendingString:@" min " ];
    NSString *addSeconds = [addMinute stringByAppendingString:secondes];
    time = [addSeconds stringByAppendingString:@" sec"];
    
    self.formatedTime = time;

    
//    if (seconds < 60 ) {
//        
//        self.formatedTime = [secondes stringByAppendingString:@"s"];
//    }else{
//        
//        self.formatedTime = time;
//    }
    

    
}



@end
