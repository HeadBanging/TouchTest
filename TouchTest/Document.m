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
#pragma mark - Window Controller

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
    
    [self.documentContent setString:((Document*)self.document).documentStorage];
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

#pragma mark - Document Controller

@implementation Document
@synthesize documentStorage;

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
    NSDictionary * typeDict;
    
    if ([typeName compare:@"public.plain-text"] == NSOrderedSame ) {
        typeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                 NSPlainTextDocumentType,
                 NSDocumentTypeDocumentAttribute,nil];
    } else {
        NSLog(@"ERROR: dataOfType =%@",typeName);
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                         code:unimpErr
                                     userInfo:NULL];
        return NULL;
    } // end if
    
    NSString * testString = @"Little Pig, Little Pig, Let Me In,\nNot by the hairs on my Chinny Chin Chin\n";
    NSData * testData = [testString dataUsingEncoding:NSASCIIStringEncoding];
    return testData;
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    if ([typeName compare:@"public.plain-text"] != NSOrderedSame) {
        NSLog(@"ERROR: readFromData ofType =%@",typeName);
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                         code:unimpErr
                                     userInfo:NULL];
        return NO;
    } // end if
    
    NSString* testString = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
    
    self.documentStorage = [NSMutableString stringWithString:testString];
    return YES;
}


@end
