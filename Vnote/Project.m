//
//  Project.m
//  Pratice
//
//  Created by Maxime BENJAMIN on 8/10/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import "Project.h"

@implementation Project
@synthesize toDoList,projectName,videoUrl,collaborators,taskHistory;


-(id)init{
    
    self = [super init];
    if(self){
        
        toDoList = [[NSMutableArray alloc]init];
        collaborators = [[NSMutableArray alloc]init];
        taskHistory = [[NSMutableArray alloc]init];
        projectName = @"New Project";
        
    }
    
    return self;
    
}

- (void) encodeWithCoder: (NSCoder *)coder{
    
    [coder encodeObject:[self toDoList] forKey:@"todolist"];
    [coder encodeObject:[self projectName] forKey:@"projectname"];
    [coder encodeObject:[self videoUrl] forKey:@"videourl"];
    [coder encodeObject:[self collaborators] forKey:@"collaborators"];
    [coder encodeObject:[self taskHistory] forKey:@"taskHistory"];


    
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        [self setToDoList: [coder decodeObjectForKey:@"todolist"]];
        [self setProjectName: [coder decodeObjectForKey:@"projectname"]];
        [self setVideoUrl: [coder decodeObjectForKey:@"videourl"]];
        [self setCollaborators: [coder decodeObjectForKey:@"collaborators"]];
        [self setTaskHistory: [coder decodeObjectForKey:@"taskHistory"]];




    }
    return self;
}


@end
