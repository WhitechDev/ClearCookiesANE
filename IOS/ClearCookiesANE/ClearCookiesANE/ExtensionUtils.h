//
//  ExtensionUtils.h
//  ImageAssistant
//
//  Created by Whitech Development on 5/06/13.
//
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

@interface ExtensionUtils : NSObject

+ (FREObject)FREObjectWithInt:(int)objcInt;

+ (FREObject)FREObjectWithBool:(BOOL)objcBool;

+ (FREObject)FREObjectWithString:(NSString*)objcString;

+ (int)intFromFREObject:(FREObject)freObject defaultValue:(int)defaultValue;

+ (double)doubleFromFREObject:(FREObject)freObject defaultValue:(double)defaultValue;

+ (BOOL)boolFromFREObject:(FREObject)freObject defaultValue:(BOOL)defaultValue;

+ (NSString*)stringFromFREObject:(FREObject)freObject defaultValue:(NSString*)defaultValue;

+ (NSArray *)arrayFromFREObject:(FREObject)freObject defaultValue:(NSArray *)defaultValue;

+ (int)intFrom:(FREObject)freObject propertyName:(const char*)propertyName defaultValue:(int)defaultValue;

+ (double)doubleFrom:(FREObject)freObject propertyName:(const char*)propertyName defaultValue:(double)defaultValue;

+ (BOOL)boolFrom:(FREObject)freObject propertyName:(const char*)propertyName defaultValue:(BOOL)defaultValue;

+ (NSString*)stringFrom:(FREObject)freObject propertyName:(const char*)propertyName defaultValue:(NSString*)defaultValue;

+ (NSString *)convertDataToHexString:(NSData*)data;

+ (void) dispatch:(FREContext)context eventType:(NSString *)type data:(NSString *)code;

+ (void) dispatch:(FREContext)context exception:(NSException *)exception fromMethod:(NSString *)methodName;

@end
