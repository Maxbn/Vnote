//
//  AppDelegate.m
//  Pratice
//
//  Created by Maxime BENJAMIN on 8/10/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate
@synthesize listTableView,projectTableView,taskEntry,projectList,
addTaskButton,removeTaskButton,playerView,timeSlider,window,selectedProject,player,playerItem,playerObserver,playerLayer
,insertVideoText,verticalSplitView;


-(id)init{
    
    self = [super init];
    if(self){
        
        [self loadDataFromDisk];
     
        
        if (!projectList) {
            projectList = [[NSMutableArray alloc]init];
        }
        
        
        [taskEntry setEnabled:NO];
        

        
    }
    
    return self;
    
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    
    [projectTableView setBackgroundColor:[NSColor clearColor]];
    
    player = [AVPlayer playerWithURL:Nil];
    
    //        creates a video layer
    
    [self.playerView setWantsLayer:YES];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    
    
    playerLayer.frame = self.playerView.layer.bounds;
    [self.playerView.layer addSublayer:playerLayer];
//    [playerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    playerLayer.autoresizingMask = kCALayerWidthSizable |
    kCALayerHeightSizable;
    
    playerItem = [AVPlayerItem playerItemWithAsset:Nil];
    
    __weak typeof(self) weakSelf = self;
    
    [player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(0.1, 100)
                                         queue:Nil
                                    usingBlock:^(CMTime time) {
                                        weakSelf.timeSlider.floatValue = CMTimeGetSeconds(weakSelf.player.currentTime);
                                    }];
    [playerLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    [listTableView setColumnAutoresizingStyle:NSTableViewSequentialColumnAutoresizingStyle];
            [projectTableView reloadData];
    
    

}


#pragma mark Buttons

- (IBAction)addTask:(id)sender {
    

    //    Gets the time of the video
    
    CMTime videoTime = player.currentTime;
    NSUInteger videoTimeCode = CMTimeGetSeconds(videoTime);
    
    //    Gets the task name from the textField
    NSString *taskName = [taskEntry stringValue];
    
    //    Checks if the textfield or the selection is empty
    if ([taskName length] == 0 || [taskEntry.stringValue isEqual: @" "]) {
        [taskEntry setStringValue:@""];
        [taskEntry setEnabled:NO];
        [player play];
        return;
    }else if ([projectTableView selectedRow] ==-1){
        return;
    }
    
//    Sets up the task
    
    Task *newTask =  [[Task alloc]init];
    newTask.taskName = taskName;
    newTask.taskTime = videoTimeCode;
    newTask.timeCode = videoTime;
    [newTask setformatedTime:videoTimeCode];
    
    newTask.checked = [[NSButton alloc]init];
    [newTask.checked setButtonType:NSSwitchButton];
    [newTask.checked setTitle:@""];
    [newTask.checked setTag:[selectedProject.toDoList count]];
    SEL aSelector = @selector(checkTask:);
    [newTask.checked setAction:aSelector];
    
    [selectedProject.toDoList addObject:newTask];

    [listTableView reloadData];
    [taskEntry setStringValue:@""];
    [taskEntry setEnabled:NO];
    
    NSString *timeDesc = (__bridge NSString *)CMTimeCopyDescription(NULL, self.player.currentTime);
    NSLog(@"Description of currentTime: %@", timeDesc);
    
    
    
}

- (IBAction)addProject:(id)sender {
    
    Project * projectToAdd = [[Project alloc]init];
    
    //    Ask to choose a file!!
    NSOpenPanel *chooseFilePanel = [NSOpenPanel openPanel];
    [chooseFilePanel setCanChooseFiles:YES];
    [chooseFilePanel setCanChooseDirectories:NO];
    
    if ( [chooseFilePanel runModal] == NSOKButton ){
        
        projectToAdd.videoUrl = [chooseFilePanel URL];
        NSURL *fileUrl = [chooseFilePanel URL];
        NSString *fileName = [[fileUrl path] lastPathComponent];
        NSString *cleanName = [fileName stringByReplacingOccurrencesOfString:@".mov" withString:@""];
        cleanName = [cleanName stringByReplacingOccurrencesOfString:@".mp4" withString:@""];
        projectToAdd.projectName = cleanName;
    }else{
        return;
    }
    
    
    
    //    Adds the project to the list
    [projectList addObject:projectToAdd];
    
    
    
    [projectTableView reloadData];
    [listTableView reloadData];
    
//    selects the last added project
    [self selectLastAddedproject];

    
}

- (IBAction)removeProject:(id)sender {
    
    
    //    Checks if a project is selected
    if ([projectTableView selectedRow] ==-1) {
        return;
    }
    
    //    Revmoes and reload
    
    [projectList removeObjectAtIndex:[projectTableView selectedRow]];
    [projectTableView deselectRow:[projectTableView selectedRow]];
    [projectTableView reloadData];
    [player replaceCurrentItemWithPlayerItem:Nil];
      [self selectLastAddedproject];
    [insertVideoText setAlphaValue:1.0];
    
    
    
}

- (IBAction)removeTask:(id)sender {
    if ([listTableView selectedRow] ==-1) {
        return;
    }
    
    //    Gets the selected Project
    Project *projectToDeleteFrom = [projectList objectAtIndex:[projectTableView selectedRow]];
    [projectToDeleteFrom.toDoList removeObjectAtIndex:[listTableView selectedRow]];
    [projectList replaceObjectAtIndex:[projectTableView selectedRow] withObject:projectToDeleteFrom];
    [listTableView deselectRow:[listTableView selectedRow]];
    
    [listTableView reloadData];
//    [projectTableView reloadData];
    
}

- (IBAction)playVideo:(id)sender {
    
    if ([player rate] != 1.f)
	{
		
		[player play];
//        [taskEntry setEnabled:NO];
	}
	else
	{
        [player pause];
        [taskEntry setEnabled:YES];
        [taskEntry selectText:taskEntry];
	}
}

- (IBAction)enterFullScreen:(id)sender {
    
    if (selectedProject != nil && (![playerView isInFullScreenMode])) {
        NSScreen *screen = [NSScreen mainScreen];
        [playerView enterFullScreenMode:screen withOptions:nil];
        [playerView setFrame:screen.visibleFrame ];
    
        }
        
    else if ([playerView isInFullScreenMode]){
            [playerView exitFullScreenModeWithOptions:nil];
        }
    
}

- (IBAction)checkTask:(id)sender{
    
//    NSLog(@"task Checked");
    NSUInteger tag = [sender tag];
    Task *checkedTask = [selectedProject.toDoList objectAtIndex:tag];
    
    checkedTask.done = (!checkedTask.done);
    [listTableView reloadData];
}

- (IBAction)exportPDF:(id)sender {
    
    //   Create an array with the requested frames
    if ([projectTableView selectedRow] !=-1) {
        Project *projectToExport = [projectList objectAtIndex:[projectTableView selectedRow]];
        NSMutableArray *framesToExport = [NSMutableArray array];
        NSMutableArray *captionToExport = [NSMutableArray array];
        
        if (projectToExport) {
            for ( Task * taskToExport in projectToExport.toDoList) {
                AVAsset *myAsset = [AVAsset assetWithURL:projectToExport.videoUrl];
                AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:myAsset];
                
                NSError *error;
                CMTime actualTime;
                CMTime captureTime = taskToExport.timeCode;
                CGImageRef frame = [imageGenerator copyCGImageAtTime:captureTime actualTime:&actualTime error:&error];
                
                if(frame != NULL){
                    
                    [framesToExport addObject:(__bridge id)(frame)];
                    CGImageRelease(frame);
                }
                
                [captionToExport addObject:taskToExport.taskName];
            }
            
        }
        
        NSSavePanel *savePanel = [NSSavePanel savePanel];
        NSString *saveName = [projectToExport.projectName stringByAppendingString:@".pdf"];
        [savePanel setNameFieldStringValue:saveName];
        NSSize pageSize = {1920,1080};
        int pageNumber = 1;
        
        
        if ([savePanel runModal] == NSOKButton) {
            
            NSPrintInfo *printInfo;
            NSPrintInfo *sharedInfo;
            NSPrintOperation *printOp;
            NSMutableDictionary *printInfoDict;
            NSMutableDictionary *sharedDict;
            
            sharedInfo = [NSPrintInfo sharedPrintInfo];
            sharedDict = [sharedInfo dictionary];
            printInfoDict = [NSMutableDictionary dictionaryWithDictionary:
                             sharedDict];
            
            [printInfoDict setObject:NSPrintSaveJob
                              forKey:NSPrintJobDisposition];
            
            [printInfoDict setObject:[[savePanel URL]path] forKey:NSPrintSavePath];
            
            
            printInfo = [[NSPrintInfo alloc] initWithDictionary: printInfoDict];
            [printInfo setHorizontalPagination: NSAutoPagination];
            [printInfo setOrientation:NSLandscapeOrientation];
            
            pdfView.frameCount = framesToExport.count;
            pdfView.frameScale = 2.25;
            pdfView.pageSize = NSMakeSize(1920, 1080);
            pdfView.frames = framesToExport;
            pdfView.captions = captionToExport;
            
            if(pdfView.frameCount > 6 && pdfView.frameCount < 13){
                pageNumber = 2;
            }else if (pdfView.frameCount > 12 && pdfView.frameCount < 19){
                pageNumber = 3;
            }else if (pdfView.frameCount > 18 && pdfView.frameCount < 25){
                pageNumber = 4;
            }
            
            NSSize pdfSize = {pageSize.width,pageSize.height *pageNumber};
            
            [pdfView setFrameSize:pdfSize];
            [printInfo setPaperSize:pageSize];
            [printInfo setVerticalPagination: NSAutoPagination];
            [printInfo setBottomMargin:0];
            [printInfo setLeftMargin:0];
            [printInfo setRightMargin:0];
            [printInfo setTopMargin:0];
            
            
            
            
            printOp = [NSPrintOperation printOperationWithView:pdfView
                                                     printInfo:printInfo];
            [printOp setShowsPrintPanel:NO];
            [printOp setShowsProgressPanel:NO];
            [printOp runOperation];
            
        }
        
    }
    
}


- (IBAction)seekToTime:(id)sender {
    
    if (selectedProject != nil) {
       
        
        CMTime time = CMTimeMakeWithSeconds(timeSlider.floatValue, 600);
        
        if ([self.timeSlider isHighlighted]) {
            [player setMuted:YES];
            [player pause];
        }
        [player seekToTime:time];
        [taskEntry setEnabled:YES];
        [taskEntry selectText:taskEntry];
//        [player pause];
        [player setMuted:NO];
    }
    

}

- (IBAction)moveOneFrameForward:(id)sender {
    [player pause];

    [playerItem stepByCount:1];
    
    
}

- (IBAction)moveOneFrameBackward:(id)sender {
    [player pause];
    [playerItem stepByCount:-1];
}

-(void)dragNewProject:(NSURL *)draggedUrl{
    
   Project * projectToAdd = [[Project alloc]init]; 

    
    if ( draggedUrl != nil ){
        
        
        projectToAdd.videoUrl = draggedUrl;
        NSURL *fileUrl = draggedUrl;
        NSString *fileName = [[fileUrl path] lastPathComponent];
        NSString *cleanName = [fileName stringByReplacingOccurrencesOfString:@".mov" withString:@""];
        cleanName = [cleanName stringByReplacingOccurrencesOfString:@".mp4" withString:@""];
        projectToAdd.projectName = cleanName;
    }else{
        return;
    }
    
    
    
    //    Adds the project to the list
    [projectList addObject:projectToAdd];
    
    
    
    [projectTableView reloadData];
    [listTableView reloadData];
    
    [self selectLastAddedproject];

}

-(void)selectLastAddedproject{
    NSIndexSet *selectionIndex;
    
    if ([projectList count] == 1) {
        selectionIndex = [NSIndexSet indexSetWithIndex:0];
        
    }else{
        
        selectionIndex = [NSIndexSet indexSetWithIndex:[projectList count]-1];
        
    }
    
    [projectTableView selectRowIndexes:selectionIndex byExtendingSelection:NO ];
    [listTableView reloadData];

    }

-(void)playerItemDidReachEnd:(NSNotification *)notification{
    
    [player seekToTime:kCMTimeZero];
    [player play];
   
}

#pragma mark Tableview stuff

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification{
    
    NSTabView *theTable = [aNotification object];
    
    if ([theTable isEqual:projectTableView] ) {
        [listTableView reloadData];
    }
    
    //    Gets the selected Project
    if ([projectList count] != 0) {
        [projectTableView setAllowsEmptySelection:NO];
    }
    
    if ([projectTableView selectedRow] != -1) {
        selectedProject = [projectList objectAtIndex:[projectTableView selectedRow]];
    }
    
    
    
    
    //    Turns ON or OFF the buttons
    if (selectedProject != nil){
        [addTaskButton setEnabled:YES];
    }else if (selectedProject == nil){
        [addTaskButton setEnabled:NO];
        
    }
    
    if ([listTableView selectedRow] != -1){
        [removeTaskButton setEnabled:YES];
    }else if ([listTableView selectedRow] == -1){
        [removeTaskButton setEnabled:NO];
    }
    
    //    Plays the right video
    
    NSURL *url;
    
    //    Shows the place holder if nothing is selected
    if (selectedProject ==nil) {
        
        
        playerItem = [AVPlayerItem playerItemWithAsset:Nil];
        
        //        Register the item to know when it ends playing
        
        
        
        
        [player replaceCurrentItemWithPlayerItem:playerItem];
        [insertVideoText setAlphaValue:1.0];
        [projectTableView reloadData];
        
    }else{
        
        
        url = selectedProject.videoUrl;
        playerItem = [AVPlayerItem playerItemWithURL:url];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(playerItemDidReachEnd:)
         name:AVPlayerItemDidPlayToEndTimeNotification
         object:playerItem];
        
        [player replaceCurrentItemWithPlayerItem:playerItem];
        
        [insertVideoText setAlphaValue:0.0];
        
        //    Sets up the time slider
        
        timeSlider.minValue = 0;
        timeSlider.maxValue = CMTimeGetSeconds(playerItem.duration);
        
        
    }
    
    //    Shows the frame linked to the task
    
    if ([listTableView selectedRow] !=-1){
        
        
        if([selectedProject.toDoList count] >= [listTableView selectedRow]){
            
            Task *selectedTask = [selectedProject.toDoList objectAtIndex:[listTableView selectedRow]];
            
            [player seekToTime:selectedTask.timeCode];
            [player pause];
//            [listTableView reloadData];
        }
        
        
    }
    
    
    
    
//    [projectTableView reloadData];
    if ([listTableView selectedRow] ==-1){
        
         [listTableView reloadData];
    }
       
   
}

//Creates the right number of rows
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    
    //    For the task
    if(aTableView == listTableView){
        
        if ([projectTableView selectedRow] == -1) {
            
            return 0;
        }
        
        
        Project *projectToDisplay = [projectList objectAtIndex:[projectTableView selectedRow]];
        return [projectToDisplay.toDoList count];
    }
    
    //    For the Projects
    else if (aTableView == projectTableView){
        return [projectList count];
        
    }
    
    
    return 0;
}

//Populates the rows

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row


{
    NSTextField *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    [result setBordered:NO];
    [[result cell] setLineBreakMode:NSLineBreakByTruncatingTail];
    [[result cell]setBackgroundColor:[NSColor clearColor]];
    [[result cell] setTruncatesLastVisibleLine:NO];
    [result setFocusRingType:NSFocusRingTypeNone];
    [tableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleRegular];



    if(tableView == listTableView){
        
        [tableView setRowHeight:22];
        
        NSString *columnIdentifer = [tableColumn identifier];
        
        if (result == nil)
        {
            
            // create the new NSTextField with a frame of the {0,0} with the width of the table
            // note that the height of the frame is not really relevant, the row-height will modify the height
            // the new text field is then returned as an autoreleased object
            
            NSRect frame = NSMakeRect(0, 0, tableView.frame.size.width, 0);
            result = [[NSTextField alloc]initWithFrame:frame];
            [result setBordered:NO];
            
            result.identifier = @"MyView";
        }
                
            
            //        Checks if a project is selected
        if (selectedProject == nil) {
                if ([columnIdentifer isEqualToString:@"taskName"]) {
                    
                    result.stringValue = @"select a project";
                    return result;
                    
                }else if ([columnIdentifer isEqualToString:@"timeCode"]) {
                    
                    result.stringValue = @"select a project";
                    return result;
                }
                
            }
            
            //      Gets the selected project
            //      Populates the name column
            if ([columnIdentifer isEqualToString:@"taskName"]) {
                
                NSMutableArray *taskList = [selectedProject.toDoList valueForKey:@"taskName"];
                NSMutableArray *checkList = selectedProject.toDoList;
                if ([taskList count] == 0) {
                    return 0;
                }
                
                NSString *theName = [taskList objectAtIndex:row];
                
                result.stringValue = theName;
                [[result cell]setBackgroundColor:[NSColor clearColor]];
                Task *task = [checkList objectAtIndex:row];
                
                if (task.done == YES) {
                    result.alphaValue = 0.2;
                }else if (task.done == NO) {
                    result.alphaValue = 1;
                }
                
                [result setEditable:YES];
                return result;
                NSLog(@"Populated the taskName Column");
                
            }
        
            //      Populates the Time Code column
            else if ([columnIdentifer isEqualToString:@"timeCode"]){
            
                NSMutableArray *taskList = [selectedProject.toDoList valueForKey:@"formatedTime"];
                NSMutableArray *timeList = selectedProject.toDoList;
                
                if ([taskList count] != 0) {
                    NSString *timeCode = [taskList objectAtIndex:row];
                    result.stringValue = timeCode;
                    [[result cell]setBackgroundColor:[NSColor clearColor]];
                    
                    Task *task = [timeList objectAtIndex:row];
                    
                    if (task.done == YES) {
                        result.alphaValue = 0.2;
                    }else if (task.done == NO) {
                        result.alphaValue = 1;
                    }
                    
                    return result;
                }
                
                NSLog(@"Populated the timeCode Column");
                
                
            }else if ([columnIdentifer isEqualToString:@"checkBox"]){
                
                NSMutableArray *checkBoxList = [selectedProject.toDoList valueForKey:@"checked"];
                NSMutableArray *boxList = selectedProject.toDoList;

                
                if ([checkBoxList count] != 0) {
                    NSButton *checkBox = [checkBoxList objectAtIndex:row];
                    
                    Task *task = [boxList objectAtIndex:row];
                    
                    if (task.done == YES) {
                        checkBox.alphaValue = 0.2;
                    }else if (task.done == NO) {
                        checkBox.alphaValue = 1;
                    }
                    
                    
                    return checkBox;
                }           
            }
            
            return 0;
            
        }
        
        //    for the project views
        else if (tableView == projectTableView){
            
            [tableView setRowHeight:23];
            [result setBordered:NO];
            
            if (result == nil)
            {
                
                // create the new NSTextField with a frame of the {0,0} with the width of the table
                // note that the height of the frame is not really relevant, the row-height will modify the height
                // the new text field is then returned as an autoreleased object
                
                NSRect frame = NSMakeRect(0, 0, tableView.frame.size.width, 0);
                
                result = [[NSTextField alloc]initWithFrame:frame];
                [result setEditable:NO];
                [result setBordered:NO];
                
                result.identifier = @"MyView";
                
            }
            
            [player pause];
            NSMutableArray *projectNameList = [projectList valueForKey:@"projectName"];
            
            NSString *projectName = [projectNameList objectAtIndex:row ];
            [[result cell] setLineBreakMode:NSLineBreakByTruncatingTail];
            [[result cell]setBackgroundColor:[NSColor clearColor]];
            
            result.stringValue = projectName;
            
            return result;
            NSLog(@"Pupulated the Project Column");
            
            
        }
        
        return 0;
        
       
}


//Makes the project names editable
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    
    //    Gets the selected row changes its name property and puts in back in

    selectedProject.projectName = anObject;
    [projectList replaceObjectAtIndex:rowIndex withObject:selectedProject];
    
    
}

#pragma mark Save program


- (NSString *) pathForDataFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder = @"~/Library/Application Support/Vnote/";
    folder = [folder stringByExpandingTildeInPath];
    
    NSURL *folderUrl = [NSURL fileURLWithPath:folder];
    
    if ([fileManager fileExistsAtPath: folder] == NO)
    {
        [fileManager createDirectoryAtURL:folderUrl
              withIntermediateDirectories:YES
                               attributes:Nil error:Nil];
    }
    
    NSString *fileName = @"Vnote.cdcvnote";
    return [folder stringByAppendingPathComponent: fileName];
}

- (void) saveDataToDisk
{
    NSString * path = [self pathForDataFile];
    
    NSMutableDictionary * rootObject;
    rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue: [self projectList] forKey:@"projects"];
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

- (void) loadDataFromDisk
{
    NSString     * path        = [self pathForDataFile];
    NSDictionary * rootObject;
    
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [self setProjectList: [rootObject valueForKey:@"projects"]];

}

- (void) applicationWillTerminate: (NSNotification *)note
{
    [self saveDataToDisk];
}

#pragma mark Split View

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex{
    
    if (splitView == verticalSplitView) {
        CGFloat screenPortion = (window.frame.size.width*1.5)/3 ;
        proposedMax = screenPortion;
        
    }else{
        proposedMax = 0;
    }
     return proposedMax;
    
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)dividerIndex{
    
    proposedMin = 50;
    
    return proposedMin;
}

@end
