/**
 * Snappy iOS Module
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "RsRbtSnappyModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#include "snappy.h"

@implementation RsRbtSnappyModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"b7a7c873-6cf8-4a69-8fec-f7163b5ccd06";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"rs.rbt.snappy";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)compressToBase64String:(id)args
{
    enum Args {
        kArgString = 0,
        kArgCount
    };
    
    ENSURE_ARG_COUNT(args, kArgCount);
    
    id inputString = [args objectAtIndex:kArgString];
    ENSURE_TYPE(inputString, NSString);
    
//    NSLog(@"[INFO] input string %@", inputString);
    NSData* inputData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"[INFO] input data %@", inputData);
    
    NSData *outputData = [NSData data];
    if ([inputData length] > 0)
    {
        const char *input = (const char *)[inputData bytes];
        size_t input_length = [inputData length];
//        NSLog(@"[INFO] input length %d", input_length);
        
        char* output = new char[snappy::MaxCompressedLength(input_length)];
        size_t output_length;
        
        snappy::RawCompress(input, input_length, output, &output_length);
//        NSLog(@"[INFO] output length %d", output_length);
        
        outputData = [NSData dataWithBytes:(const void *)output length:output_length];
    }
//    NSLog(@"[INFO] output data %@", outputData);
    
    NSString *base64String = [outputData base64EncodedStringWithOptions:0];
//    NSLog(@"[INFO] output base64 string %@", base64String);
    
    return base64String;
}

-(id)uncompressFromBase64String:(id)args
{
    enum Args {
        kArgString = 0,
        kArgCount
    };
    
    ENSURE_ARG_COUNT(args, kArgCount);
    
    id inputString = [args objectAtIndex:kArgString];
    ENSURE_TYPE(inputString, NSString);
    
//    NSLog(@"[INFO] input string %@", inputString);
    NSData *inputData = [[NSData alloc] initWithBase64EncodedString:inputString options:0];
//    NSLog(@"[INFO] input data %@", inputData);
    
    NSData *outputData = [NSData data];
    if ([inputData length] > 0)
    {
        const char *input = (const char *)[inputData bytes];
        size_t input_length = [inputData length];
//        NSLog(@"[INFO] input length %d", input_length);
        
        size_t output_length;
        snappy::GetUncompressedLength(input, input_length, &output_length);
        char* output = new char[output_length];
        
        snappy::RawUncompress(input, input_length, output);
//        NSLog(@"[INFO] output length %d", output_length);
        
        outputData = [NSData dataWithBytes:(const void *)output length:output_length];
    }
//    NSLog(@"[INFO] output data %@", outputData);
    
    NSString *decodedString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
//    NSLog(@"[INFO] output decoded string %@", decodedString);
    
    return decodedString;
}

@end
