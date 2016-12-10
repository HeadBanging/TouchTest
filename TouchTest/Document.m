//
//  Document.m
//  TouchTest
//
//  Created by Headbanger on 08/12/2016.
//  Copyleft 2016 Headbanger. Some rights reserved.
//

#import "Document.h"


static NSTouchBarItemIdentifier WindowControllerLabelIdentifier = @"com.TouchTest.windowController.label";

@interface DocumentWindowController () <NSTouchBarDelegate>

@end

@implementation DocumentWindowController
#pragma mark - Touchbar Handlers

- (id)init {
    if (self=[super initWithWindowNibName:@"Document"])
    {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (NSTouchBar *)makeTouchBar
{
    NSTouchBar *bar = [[NSTouchBar alloc] init];
    bar.delegate = self;
    
    // Set the default ordering of items.
    bar.defaultItemIdentifiers = @[WindowControllerLabelIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
    
    return bar;
}

- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:WindowControllerLabelIdentifier])
    {
        NSTextField *theLabel = [NSTextField labelWithString:@"TouchTest"];
        
        NSCustomTouchBarItem *customItemForLabel =
        [[NSCustomTouchBarItem alloc] initWithIdentifier:WindowControllerLabelIdentifier];
        customItemForLabel.view = theLabel;
        
        // We want this label to always be visible no matter how many items are in the NSTouchBar instance.
        customItemForLabel.visibilityPriority = NSTouchBarItemPriorityHigh;
        
        return customItemForLabel;
    }
    
    return nil;
}
@end

@interface Document ()

@end

@implementation Document

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (void)makeWindowControllers {
    DocumentWindowController *controller = [[DocumentWindowController alloc]initWithWindowNibName:[self windowNibName]
                                            ];

    [self addWindowController:controller];
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return YES;
}


@end
