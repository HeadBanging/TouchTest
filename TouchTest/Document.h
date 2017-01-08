//
//  Document.h
//  TouchTest
//
//  Created by Headbanger on 08/12/2016.
//  Copyleft 2016 Headbanger. Some rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DocumentWindowController : NSWindowController
{
    
}
@property (assign) IBOutlet  NSTextView* documentContent;

@end

@interface Document : NSDocument
{
//   id documentStorage;
}
@property (readwrite, nonatomic, retain) NSMutableString *documentStorage;

@end

