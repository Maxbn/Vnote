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
#import "myTableView.h"
#import "playerView.h"
#import "contentView.h"
#import "projectButtonView.h"
#import "playButton.h"
#import "sliderCell.h"
#import "slider.h"
#import "mailButton.h"
#import "forwardButton.h"
#import "backwardButton.h"
#import "exportButton.h"


@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource,NSSplitViewDelegate,NSTextFieldDelegate>{
    
    
    IBOutlet PDFview *pdfView;
    IBOutlet dragView *myDragView;
    
}


@property (strong,nonatomic)NSMutableArray *projectList;
@property (strong) Project *selectedProject;


@property (weak) IBOutlet playerView *videoContainerView;
@property (weak) IBOutlet contentView *myContentView;
@property (weak) IBOutlet NSView *playerControls;
@property (weak) IBOutlet playerView *playerViewHolder;
@property (weak) IBOutlet playerView *myPlayerView;

@property (strong) AVPlayer *player;
@property (strong,nonatomic)AVPlayerItem *playerItem;
@property (strong,nonatomic)AVPlayerLayer *playerLayer;
@property (strong) id playerObserver;


@property (strong) IBOutlet NSTextField *result;
@property (strong) NSMutableArray *textCellSize;
@property BOOL historyShouldBeVisible;
@property BOOL isFullScreen;
@property (strong,nonatomic)NSArray *filterArray;



@property (strong) IBOutlet NSButton *removeTaskButton;
@property (strong) IBOutlet NSButton *addTaskButton;
@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTableView *projectTableView;
@property (strong) IBOutlet NSTableView *listTableView;
@property (strong) IBOutlet NSTextField *taskEntry;

@property (strong) IBOutlet sliderCell *timeSlider;
@property (strong) IBOutlet NSTextField *insertVideoText;
@property (strong) IBOutlet NSSplitView *verticalSplitView;

@property (strong) IBOutlet NSBox *taskInfoView;
@property (weak) IBOutlet NSScrollView *taskScrollView;

@property (weak) IBOutlet NSTextField *welcomeText;
@property (weak) IBOutlet NSTextField *editTaskField;
@property (weak) IBOutlet NSTextField *assignedToLabel;

@property (weak) IBOutlet NSComboBox *assignementBox;

@property (weak) IBOutlet NSButton *removeCollaborator;
@property (weak) IBOutlet NSButton *showHistoryButton;
@property (weak) IBOutlet NSBox *fullScreenPlayerControlBox;

@property (weak) IBOutlet projectButtonView *myProjectButtonView;

@property (weak) IBOutlet NSButton *playButton;

- (IBAction)addProject:(id)sender;
- (IBAction)removeProject:(id)sender;

- (IBAction)addTask:(id)sender;
- (IBAction)removeTask:(id)sender;
- (IBAction)checkTask:(id)sender;
- (IBAction)showHistory:(id)sender;

- (IBAction)removeCollaborator:(id)sender;


- (IBAction)playVideo:(id)sender;
- (IBAction)enterFullScreen:(id)sender;

- (IBAction)exportPDF:(id)sender;
- (IBAction)seekToTime:(id)sender;
- (IBAction)moveOneFrameForward:(id)sender;
- (IBAction)moveOneFrameBackward:(id)sender;

- (IBAction)mailPDF:(id)sender;

@property (weak) IBOutlet NSProgressIndicator *progressBar;

//- (IBAction)openInfo:(id)sender;

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index;
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox;

- (NSString *) pathForDataFile;
- (void) saveDataToDisk;
- (void) loadDataFromDisk;

-(void)dragNewProject:(NSURL *)draggedUrl;
-(void)selectLastAddedproject;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex;

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row;




- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex;
- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)dividerIndex;


- (void)controlTextDidEndEditing:(NSNotification *)aNotification;


- (void)openInfoPanel;


-(void)animateFilterIn;


@end
