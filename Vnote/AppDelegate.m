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
addTaskButton,removeTaskButton,myPlayerView,timeSlider,window,selectedProject,player,playerItem,playerObserver,playerLayer
,insertVideoText,verticalSplitView,textCellSize,result,taskInfoView,editTaskField,assignedToLabel,assignementBox,removeCollaborator,historyShouldBeVisible,isFullScreen;

- (void)awakeFromNib{
    
    
    [assignementBox setStringValue:@"choose"];
    [listTableView registerForDraggedTypes:[NSArray arrayWithObject:@"Task"]];
   [addTaskButton setKeyEquivalent:@"\r"];
    
}

-(id)init{
    
    self = [super init];
    if(self){
        
        [self loadDataFromDisk];
     
        
        if (!projectList) {
            projectList = [[NSMutableArray alloc]init];
            textCellSize = [[NSMutableArray alloc]init];
        }
        
        [[editTaskField cell]setLineBreakMode:NSLineBreakByWordWrapping];
        [taskEntry setEnabled:NO];
        historyShouldBeVisible = NO;
        isFullScreen = NO;
        
        
        

        
    }
    
    return self;
    
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    
    [projectTableView setBackgroundColor:[NSColor clearColor]];
    
    player = [AVPlayer playerWithURL:Nil];
    
    myPlayerView.player = player;
    
    //        creates a video layer
    
//    [self.myPlayerView setWantsLayer:YES];
//    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    
//    
//    
//    playerLayer.frame = self.myPlayerView.layer.bounds;
//    [self.myPlayerView.layer addSublayer:playerLayer];
////    [playerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    playerLayer.autoresizingMask = kCALayerWidthSizable |
//    kCALayerHeightSizable;
//    
//    playerItem = [AVPlayerItem playerItemWithAsset:Nil];
    
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
    if ([[sender identifier]isEqualToString:@"addTaskButton"]) {
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
        
    }
    
  
   
    
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
    
    //    Removes and reload
    
    [projectList removeObjectAtIndex:[projectTableView selectedRow]];
    [projectTableView deselectRow:[projectTableView selectedRow]];
    [projectTableView reloadData];
    
    if ([projectList count] == 0) {
        [player replaceCurrentItemWithPlayerItem:Nil];
    }

    [self selectLastAddedproject];
//    [editTaskField setEnabled:NO];
    [insertVideoText setAlphaValue:1.0];
    
    
    
}

- (IBAction)removeTask:(id)sender {
    if ([listTableView selectedRow] ==-1) {
        return;
    }
    
    //    Gets the selected Project
    
    
    
    Project *projectToDeleteFrom = [projectList objectAtIndex:[projectTableView selectedRow]];
    Task *taskForHistory = [selectedProject.toDoList objectAtIndex:[listTableView selectedRow]];
    
    [selectedProject.taskHistory addObject:taskForHistory];
    
    [projectToDeleteFrom.toDoList removeObjectsAtIndexes:[listTableView selectedRowIndexes]];
    
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
    
    if (selectedProject != nil && (![myPlayerView isInFullScreenMode])) {
        NSScreen *screen = [NSScreen mainScreen];
        [myPlayerView enterFullScreenMode:screen withOptions:nil];
    
        [[myPlayerView animator]setFrame:[screen frame]];
        [self.window makeFirstResponder:self.window];
        
       

        
  
        
    
        }
        
//    else if ([myPlayerView isInFullScreenMode]){
//            [myPlayerView exitFullScreenModeWithOptions:nil];
////            [[myPlayerView animator] setFrame:
//            isFullScreen = NO;
//        }
//    
}

- (IBAction)checkTask:(id)sender{
    
    NSUInteger tag = [sender tag];
    
    Task *checkedTask = [[Task alloc]init];
    
    if (historyShouldBeVisible) {
        checkedTask = [selectedProject.taskHistory objectAtIndex:tag];

    }else{
        checkedTask = [selectedProject.toDoList objectAtIndex:tag];

    }
    
    checkedTask.done = (!checkedTask.done);
    
    if (checkedTask.done == YES) {
        [selectedProject.taskHistory addObject:checkedTask];
        [selectedProject.toDoList removeObjectAtIndex:tag];
        
    } else if (checkedTask.done == NO) {
        [selectedProject.toDoList addObject:checkedTask];
        [selectedProject.taskHistory removeObjectAtIndex:tag];
    }
    
    [listTableView reloadData];

    
}

- (IBAction)showHistory:(id)sender {
    
    historyShouldBeVisible = !historyShouldBeVisible;
    
    [listTableView reloadData];
}

- (IBAction)removeCollaborator:(id)sender {
    
    NSString *personToRemove = [assignementBox stringValue];
    NSUInteger personIndex =[assignementBox indexOfItemWithObjectValue:personToRemove];
    [selectedProject.collaborators removeObjectAtIndex:personIndex];
    
    NSString *personInCharge = [[selectedProject.toDoList objectAtIndex:[listTableView selectedRow]] assignedTo];
    if ([personInCharge isEqualToString:personToRemove]) {
        [[selectedProject.toDoList objectAtIndex:[listTableView selectedRow]] setAssignedTo:nil];
    }
    
    for (Task* task in selectedProject.toDoList){
        
        if ([task.assignedTo isEqualToString:personToRemove]) {
            task.assignedTo = nil;
        }
    }

    
    [assignementBox removeAllItems];
    [assignementBox addItemsWithObjectValues:selectedProject.collaborators];
    [assignementBox setStringValue:@" "];
}


- (IBAction)exportPDF:(id)sender {
    
    //   Create an array with the requested frames
    if ([projectTableView selectedRow] !=-1) {
        Project *projectToExport = self.selectedProject;
        NSMutableArray *framesToExport = [NSMutableArray array];
        NSMutableArray *captionToExport = [NSMutableArray array];
        NSMutableArray *timeCodesToExport = [NSMutableArray array];
        NSMutableArray *assignementsToExport = [NSMutableArray array];
        
        if (projectToExport) {
            for ( Task * taskToExport in projectToExport.toDoList) {
                AVAsset *myAsset = [AVAsset assetWithURL:projectToExport.videoUrl];
                AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:myAsset];
                
                CGSize maxSize = CGSizeMake(602, 601);
                imageGenerator.maximumSize = maxSize;
                imageGenerator.requestedTimeToleranceAfter = kCMTimeZero;
                imageGenerator.requestedTimeToleranceBefore = kCMTimeZero;
                
                NSError *error;
                CMTime captureTime = taskToExport.timeCode;
                
                
                CGImageRef frame = [imageGenerator copyCGImageAtTime:captureTime actualTime:nil error:&error];
                
                
                if(frame != NULL){
                    
                    [framesToExport addObject:(__bridge id)(frame)];
                    CGImageRelease(frame);
                }
                
                if (taskToExport.assignedTo == Nil) {
                    taskToExport.assignedTo = @" ";
                }
                
                [captionToExport addObject:taskToExport.taskName];
                [timeCodesToExport addObject:taskToExport.formatedTime];
                [assignementsToExport addObject:taskToExport.assignedTo];
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
            pdfView.timeCodes = timeCodesToExport;
            pdfView.assignements = assignementsToExport;
            
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

//- (IBAction)openInfo:(id)sender {
//   infoButton *button = (infoButton *)sender;
//    NSLog(@"%ld",(long)button.index);
//}




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
        
        [taskInfoView setHidden:YES];
        [addTaskButton setEnabled:YES];
    }else if (selectedProject == nil || ![editTaskField isHidden]){
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
        NSNumber *number = [NSNumber numberWithFloat:CMTimeGetSeconds(playerItem.asset.duration)];
        
        NSUInteger maxValue = [number doubleValue];


        timeSlider.maxValue =  maxValue;
        
        
    }
    
    //    Shows the frame linked to the task
    
    if ([listTableView selectedRow] !=-1){
        
        
        if([selectedProject.toDoList count] >= [listTableView selectedRow]){
            
            Task *selectedTask = [selectedProject.toDoList objectAtIndex:[listTableView selectedRow]];
            
//            [player seekToTime:selectedTask.timeCode];
            [player seekToTime:selectedTask.timeCode toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
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

        if (historyShouldBeVisible) {
            return [projectToDisplay.taskHistory count];

        }else{
            return [projectToDisplay.toDoList count];

        }
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
    
    
    result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    

    
    [result setBordered:NO];
    [[result cell] setLineBreakMode:NSLineBreakByTruncatingTail];
    [[result cell]setBackgroundColor:[NSColor clearColor]];
    [[result cell] setTruncatesLastVisibleLine:NO];
    [result setFocusRingType:NSFocusRingTypeNone];
    [tableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleRegular];
    
    if (historyShouldBeVisible) {
        [listTableView setAlphaValue:0.2];
    }else{
        [listTableView setAlphaValue:1];

    }



    if(tableView == listTableView){
        
        
        
        NSString *columnIdentifer = [tableColumn identifier];
        
        if (result == nil)
        {
            
            // create the new NSTextField with a frame of the {0,0} with the width of the table
            // note that the height of the frame is not really relevant, the row-height will modify the height
            // the new text field is then returned as an autoreleased object
            
            NSRect frame = NSMakeRect(0, 0, tableView.frame.size.width, 0);
            
//            openInfoButton = [[infoButton alloc]init];
//            [openInfoButton setIndex:row];
//            [openInfoButton setAction:@selector(openInfo:)];
            
            result = [[NSTextField alloc]initWithFrame:frame];
            [result setDelegate:self];
            [result setBordered:NO];
            
            result.identifier = @"MyView";
        }
                
            //      Populates the name column
            if ([columnIdentifer isEqualToString:@"taskName"]) {
                
                if (historyShouldBeVisible) {
                    
                    [[result cell] setLineBreakMode:NSLineBreakByTruncatingTail];
                    
                    NSMutableArray *taskList = [selectedProject.taskHistory valueForKey:@"taskName"];
                    NSMutableArray *checkList = selectedProject.taskHistory;
                    if ([taskList count] == 0) {
                        return 0;
                    }
                    
                    //                Sets the font and size
                    NSString *theName = [taskList objectAtIndex:row];
                    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
                    NSFont *font = [NSFont fontWithName:@"Arial" size:19];
                    [attributes setObject:font forKey:NSFontAttributeName];
                    
                    
                    result.stringValue = theName;
                    [[result cell]setBackgroundColor:[NSColor clearColor]];
                    Task *task = [checkList objectAtIndex:row];
                    
                    
                    if (task.done == YES) {
                        result.alphaValue = 0.2;
                    }else if (task.done == NO) {
                        result.alphaValue = 1;
                    }
                    
                    [result setEditable:NO];
                    
                    
                    
                    
                    
                    //                [[result cell]setDoubleAction:@selector(openInfoPanel)];
                    [tableView setDoubleAction:@selector(openInfoPanel)];
                    
                    return result;
                    NSLog(@"Populated the taskName Column");
                    
                }else{
                    
                    [[result cell] setLineBreakMode:NSLineBreakByTruncatingTail];
                    
                    
                    NSMutableArray *taskList = [selectedProject.toDoList valueForKey:@"taskName"];
                    NSMutableArray *checkList = selectedProject.toDoList;
                    if ([taskList count] == 0) {
                        return 0;
                    }
                    
                    //                Sets the font and size
                    NSString *theName = [taskList objectAtIndex:row];
                    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
                    NSFont *font = [NSFont fontWithName:@"Arial" size:19];
                    [attributes setObject:font forKey:NSFontAttributeName];
                    
                    
                    result.stringValue = theName;
                    [[result cell]setBackgroundColor:[NSColor clearColor]];
                    Task *task = [checkList objectAtIndex:row];
                    
                    
                    if (task.done == YES) {
                        result.alphaValue = 0.2;
                    }else if (task.done == NO) {
                        result.alphaValue = 1;
                    }
                    
                    [result setEditable:NO];
                    
               
                    [tableView setDoubleAction:@selector(openInfoPanel)];
                    
                    return result;
                    NSLog(@"Populated the taskName Column");
                    
                }
                

            
    
            }
        
            //      Populates the Time Code column
            else if ([columnIdentifer isEqualToString:@"timeCode"]){
                
                if (historyShouldBeVisible) {
                    
                    NSMutableArray *taskList = [selectedProject.taskHistory valueForKey:@"formatedTime"];
                    NSMutableArray *timeList = selectedProject.taskHistory;
                    
                    if ([taskList count] != 0) {
                        NSString *timeCode = [taskList objectAtIndex:row];
                        result.stringValue = timeCode;
                        [[result cell]setBackgroundColor:[NSColor clearColor]];
                        
                        Task *task = [timeList objectAtIndex:row];
                        
                        if (task.done == YES) {
                            [result setAlphaValue:0.2];
                            //                        result.alphaValue = 0.2;
                        }else if (task.done == NO) {
                            result.alphaValue = 1;
                        }
                        
                        [tableView setRowHeight:22];
                        [result setEditable:NO];
                        
                        return result;
                    }

                    
                }else{
                    NSMutableArray *taskList = [selectedProject.toDoList valueForKey:@"formatedTime"];
                    NSMutableArray *timeList = selectedProject.toDoList;
                    
                    if ([taskList count] != 0) {
                        NSString *timeCode = [taskList objectAtIndex:row];
                        result.stringValue = timeCode;
                        [[result cell]setBackgroundColor:[NSColor clearColor]];
                        
                        Task *task = [timeList objectAtIndex:row];
                        
                        if (task.done == YES) {
                            [result setAlphaValue:0.2];
                            //                        result.alphaValue = 0.2;
                        }else if (task.done == NO) {
                            result.alphaValue = 1;
                        }

                        [tableView setRowHeight:22];
                        [result setEditable:NO];
                        
                        return result;
                    }

                }
            
                
                NSLog(@"Populated the timeCode Column");
                
                
            }
            else if ([columnIdentifer isEqualToString:@"checkBox"]){
                
                if (historyShouldBeVisible) {
                    
                    
                    NSMutableArray *checkBoxList = [selectedProject.taskHistory valueForKey:@"checked"];
                    NSMutableArray *boxList = selectedProject.taskHistory;
                    
                    
                    if ([checkBoxList count] != 0) {
                        NSButton *checkBox = [checkBoxList objectAtIndex:row];
                        [checkBox setAction:@selector(checkTask:)];
                        
                        Task *task = [boxList objectAtIndex:row];
                        [checkBox setTag:row];
                        
                        if (task.done == YES) {
                            checkBox.alphaValue = 0.2;
                        }else if (task.done == NO) {
                            checkBox.alphaValue = 1;
                        }
                        
                        
                        return checkBox;
                    }
                }else{
                    
                    NSMutableArray *checkBoxList = [selectedProject.toDoList valueForKey:@"checked"];
                    NSMutableArray *boxList = selectedProject.toDoList;
                    
                    
                    if ([checkBoxList count] != 0) {
                        NSButton *checkBox = [checkBoxList objectAtIndex:row];
                        [checkBox setAction:@selector(checkTask:)];
                        
                        Task *task = [boxList objectAtIndex:row];
                        [checkBox setTag:row];
                        
                        if (task.done == YES) {
                            checkBox.alphaValue = 0.2;
                        }else if (task.done == NO) {
                            checkBox.alphaValue = 1;
                        }
                        
                        
                        return checkBox;
                    
                }
                
            }
            }
            
            return 0;
            
       
        
        //    for the project views
    }else if (tableView == projectTableView){
            
            [tableView setRowHeight:23];
            
            [result setBordered:NO];
            
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
            
            [player pause];
            NSMutableArray *projectNameList = [projectList valueForKey:@"projectName"];
            
            NSString *projectName = [projectNameList objectAtIndex:row ];
            [[result cell] setLineBreakMode:NSLineBreakByTruncatingTail];
            [[result cell]setBackgroundColor:[NSColor clearColor]];
            [result setEditable:NO];
            
            result.stringValue = projectName;
            
            return result;
        
            NSLog(@"Pupulated the Project Column");
            
            
        }
        
        return 0;
        
       
 }



//Makes the task editable
- (void)controlTextDidEndEditing:(NSNotification *)aNotification{
    
    [addTaskButton setEnabled:NO];

    
    NSTextField *newTextField = (NSTextField *)[aNotification object];
    NSString *newValue = newTextField.stringValue;
    
    
  
    
    [addTaskButton setEnabled:NO];
    
    
    
    if (newTextField == editTaskField) {
        NSUInteger index = [listTableView selectedRow];
        [[selectedProject.toDoList objectAtIndex:[listTableView selectedRow]] setTaskName:newValue];

        [listTableView reloadData];
        NSIndexSet *selectedRowIndex = [NSIndexSet indexSetWithIndex: index];
        [listTableView selectRowIndexes:selectedRowIndex byExtendingSelection:NO];
        
        [self openInfoPanel];

    }else if (newTextField == assignementBox){
        NSArray *listOfNames = [assignementBox objectValues];
        
        NSString * personName = assignementBox.stringValue;
        
        if ([personName isEqualToString:@" "]) {
            return;
        }
        
        if (![listOfNames containsObject:personName]) {
            [assignementBox addItemWithObjectValue:personName];
            selectedProject.collaborators = [NSMutableArray arrayWithArray:[assignementBox objectValues]];
        }
        
        [[selectedProject.toDoList objectAtIndex:[listTableView selectedRow]] setAssignedTo:personName];

        
        
        
    }
 
    
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


-(void)openInfoPanel{
    
//    Turns on the appopriate button (Make simpler with a box)
    
    
    [editTaskField setHidden:NO];
    [assignedToLabel setHidden:NO];
    [assignementBox setHidden:NO];
    [removeCollaborator setHidden:NO];
    
//    Disables the video player
    
    playerItem = [AVPlayerItem playerItemWithAsset:Nil];
    [player replaceCurrentItemWithPlayerItem:playerItem];
    
//    Fills the textfied with the task name
    
    NSString *newStringValue = [[selectedProject.toDoList objectAtIndex:[listTableView selectedRow]] taskName];
    editTaskField.stringValue = newStringValue ;
    [taskInfoView setHidden:NO];
    
//    Fills the combobox with the values
    
    if ([assignementBox objectValues] != selectedProject.collaborators) {
        
        [assignementBox removeAllItems];
        [assignementBox addItemsWithObjectValues:selectedProject.collaborators];

    }
    
//    Displays the person it's assigned to
    
    NSString *personInCharge = [[selectedProject.toDoList objectAtIndex:[listTableView selectedRow]] assignedTo];
    
    if (personInCharge != Nil) {
        
        [assignementBox setStringValue:personInCharge];

    }else{
        
        [assignementBox setStringValue:@" "];
    }

    
    [addTaskButton setEnabled:NO];

    
}

#pragma mark Combo Box

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox{
    
    return [selectedProject.collaborators count];
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index{
    
    return [selectedProject.collaborators objectAtIndex:index];
}

#pragma mark Tableview reordering
- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard {
      // Drag and drop support
       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
      [pboard declareTypes:[NSArray arrayWithObject:@"Task"] owner:self];
      [pboard setData:data forType:@"Task"];
     return YES;
}

- (NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id )info proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)op {
    // Add code here to validate the drop
    
     return NSDragOperationEvery;
}

- (BOOL)tableView:(NSTableView*)tv acceptDrop:(id )info row:(int)row dropOperation:(NSTableViewDropOperation)op {

    NSPasteboard *pboard = [info draggingPasteboard];
    NSData *data = [pboard dataForType:@"Task"];
    NSIndexSet* rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSUInteger from = [rowIndexes firstIndex];
    
    Task *newTask = [selectedProject.toDoList objectAtIndex:from];
    
    [selectedProject.toDoList removeObjectAtIndex:from];
    
    if (row > [selectedProject.toDoList count]) {
        
//        [newTask.checked setTag:(row-1)];
        [selectedProject.toDoList addObject:newTask];
        
    }else{
        [selectedProject.toDoList insertObject:newTask atIndex:row];
        [newTask.checked setTag:row];
        
    }
    
    
    
    [listTableView reloadData];
    
    
    
//   [selectedProject.toDoList insertObject:movedTask atIndex:row];
//    [listTableView reloadData];

    
    return YES;
}

#pragma mark Fullscreen Player




@end
