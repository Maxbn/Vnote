//
//  AppDelegate.h
//  Vnote
//
//  Created by Maxime BENJAMIN on 8/19/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Project.h"
#import "Task.h"
#import "PDFview.h"
#import "dragView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource,NSSplitViewDelegate>{
    

    
    IBOutlet PDFview *pdfView;
    IBOutlet dragView *myDragView;
    
}


@property (strong,nonatomic)NSMutableArray *projectList;
@property (strong) Project *selectedProject;
@property (strong) AVPlayer *player;
@property (strong,nonatomic)AVPlayerItem *playerItem;
@property (strong,nonatomic)AVPlayerLayer *playerLayer;
@property (strong) id playerObserver;

@property (strong) IBOutlet NSButton *removeTaskButton;
@property (strong) IBOutlet NSButton *addTaskButton;
@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTableView *projectTableView;
@property (strong) IBOutlet NSTableView *listTableView;
@property (strong) IBOutlet NSTextField *taskEntry;
@property (strong) IBOutlet NSView *playerView;
@property (strong) IBOutlet NSSliderCell *timeSlider;
@property (strong) IBOutlet NSTextField *insertVideoText;
@property (strong) IBOutlet NSSplitView *verticalSplitView;








- (IBAction)addProject:(id)sender;
- (IBAction)removeProject:(id)sender;

- (IBAction)addTask:(id)sender;
- (IBAction)removeTask:(id)sender;
- (IBAction)checkTask:(id)sender;

- (IBAction)playVideo:(id)sender;
- (IBAction)enterFullScreen:(id)sender;

- (IBAction)exportPDF:(id)sender;
- (IBAction)seekToTime:(id)sender;
- (IBAction)moveOneFrameForward:(id)sender;
- (IBAction)moveOneFrameBackward:(id)sender;



- (NSString *) pathForDataFile;
- (void) saveDataToDisk;
- (void) loadDataFromDisk;

-(void)dragNewProject:(NSURL *)draggedUrl;
-(void)selectLastAddedproject;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex;

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification;

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex;
- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)dividerIndex;

@end
