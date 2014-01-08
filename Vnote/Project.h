//
//  Project.h
//  Pratice
//
//  Created by Maxime BENJAMIN on 8/10/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject<NSCoding>{
    
    NSString *projectName;
    NSMutableArray *toDoList;
    NSURL *videoUrl;
}

@property (strong,nonatomic)NSMutableArray *toDoList;
@property (strong,nonatomic)NSMutableArray *taskHistory;
@property (strong,nonatomic)NSMutableArray *collaborators;
@property (strong,nonatomic)NSString *projectName;
@property (strong, nonatomic) NSURL *videoUrl;
@end
