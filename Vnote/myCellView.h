//
//  myCellView.h
//  Vnote
//
//  Created by Maxime BENJAMIN on 10/20/13.
//  Copyright (c) 2013 Maxime BENJAMIN. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface myCellView : NSTableCellView <NSTextFieldDelegate>

@property BOOL editing;
@property IBOutlet NSTextField *taskName;

- (BOOL)control:(NSControl*)control textShouldBeginEditing:(NSText *)fieldEditor;

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor;



- (void)textDidEndEditing:(NSNotification *)aNotification;
@end
