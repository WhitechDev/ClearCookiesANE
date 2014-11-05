//
//  ExtensionUtils.m
//  ImageAssistant
//
//  Created by Whitech Development on 5/06/13.
//
//

#import "ExtensionUtils.h"

@implementation ExtensionUtils


+ (FREObject)FREObjectWithInt:(int)objcInt
{
	FREObject returnFREobject = NULL;
    
	FRENewObjectFromInt32(objcInt, &returnFREobject);
    
	return returnFREobject;
}

+ (FREObject)FREObjectWithBool:(BOOL)objcBool
{
	FREObject returnFREobject = NULL;
    
	FRENewObjectFromBool(objcBool, &returnFREobject);
    
	return returnFREobject;
}

+ (FREObject)FREObjectWithString:(NSString*)objcString
{
	FREObject returnFREobject = NULL;
    const uint8_t *strAS = (const uint8_t *)[objcString UTF8String];
    
    FRENewObjectFromUTF8(strlen((const char *)strAS) + 1, strAS, &returnFREobject);
	
	return returnFREobject;
}

+ (int)intFromFREObject:(FREObject)freObject defaultValue:(int)defaultValue
{
    int32_t asNumber = defaultValue;
    FREObjectType freObjectType = FRE_TYPE_NULL;
    
    FREGetObjectType(freObject, &freObjectType);
    
    if ( freObjectType == FRE_TYPE_NUMBER )
    {
        FREGetObjectAsInt32(freObject, &asNumber);
    }
    else NSLog(@"intFromFREObject: FREObject was not a number, returning default value");
    
    return asNumber;
}

+ (double)doubleFromFREObject:(FREObject)freObject defaultValue:(double)defaultValue
{
    double asNumber = defaultValue;
    FREObjectType freObjectType = FRE_TYPE_NULL;
    
    FREGetObjectType(freObject, &freObjectType);
    
    if (freObjectType == FRE_TYPE_NUMBER)
    {
        FREGetObjectAsDouble(freObject, &asNumber);
    }
    else NSLog(@"doubleFromFREObject: FREObject was not a number, returning default value");
    
    return asNumber;
}

+ (BOOL)boolFromFREObject:(FREObject)freObject defaultValue:(BOOL)defaultValue
{
    uint32_t asBool = defaultValue;
    FREObjectType freObjectType = FRE_TYPE_NULL;
    
    FREGetObjectType(freObject, &freObjectType);
    
    if ( freObjectType == FRE_TYPE_BOOLEAN )
    {
        FREGetObjectAsBool(freObject, &asBool);
    }
    else NSLog(@"boolFromFREObject: FREObject was not boolean, returning default value");
    
    return (BOOL)asBool;
}

+ (NSString*)stringFromFREObject:(FREObject)freObject defaultValue:(NSString*)defaultValue
{
    uint32_t        strLen = 0;
    const uint8_t   *strAS = nil;
    NSString        *returnString = defaultValue;
    FREObjectType   freObjectType = FRE_TYPE_NULL;
    FREGetObjectType(freObject, &freObjectType);
    
    if (freObjectType == FRE_TYPE_STRING )
    {
        FREGetObjectAsUTF8(freObject, &strLen, &strAS); // NOTE: Memory allocated for strAS is managed by FRE library.
        returnString = [[[NSString alloc] initWithBytes:strAS length:strLen encoding:NSUTF8StringEncoding] autorelease];
    }
    else if ( freObjectType == FRE_TYPE_NULL ) // Null string is a valid value
    {
        return nil;
    }
    else NSLog(@"getStringFromFREObject: FREObject was not a string, returning default value");
    
    return returnString;
}

+ (NSArray *)arrayFromFREObject:(FREObject)freObject defaultValue:(NSArray *)defaultValue
{
    NSArray* array = defaultValue;
    FREObjectType freObjectType = FRE_TYPE_NULL;
    
    FREGetObjectType(freObject, &freObjectType);
    
    if ( freObjectType == FRE_TYPE_ARRAY )
    {
        uint32_t length;
        FREResult result = FREGetArrayLength(freObject, &length);
        
        if ( result == FRE_OK )
        {
            NSMutableArray* mArray = [[[NSMutableArray alloc] init] autorelease];
            
            for(uint32_t i = 0; i < length; i++)
            {
                
                FREObject value;
                
                result = FREGetArrayElementAt(freObject, i, &value);
                
                if ( result == FRE_OK ) [mArray addObject:[ExtensionUtils stringFromFREObject:value defaultValue:nil]];
                else [mArray addObject:nil];
            }
            
            array = mArray;
        }
    }
    
    return array;
}

+ (int)intFrom:(FREObject)freObject propertyName:(const char*)propertyName defaultValue:(int)defaultValue
{
    int propertyValue = defaultValue;
    FREObject propertyObj = NULL;
    FREResult freResult = FREGetObjectProperty(freObject, (const uint8_t *)propertyName, &propertyObj, nil);
    
    if ( freResult == FRE_OK )
    {
        propertyValue = [ExtensionUtils intFromFREObject:propertyObj defaultValue:defaultValue];
    }
    
    return propertyValue;
}

+ (double)doubleFrom:(FREObject)freObject propertyName:(const char*)propertyName defaultValue:(double)defaultValue
{
    double propertyValue = defaultValue;
    FREObject propertyObj = NULL;
    FREResult freResult = FREGetObjectProperty(freObject, (const uint8_t *)propertyName, &propertyObj, nil);
    
    if ( freResult == FRE_OK )
    {
        propertyValue = [ExtensionUtils doubleFromFREObject:propertyObj defaultValue:defaultValue];
    }
    
    return propertyValue;
}

+ (BOOL)boolFrom:(FREObject)freObject propertyName:(const char*)propertyName defaultValue:(BOOL)defaultValue
{
    BOOL propertyValue = defaultValue;
    FREObject propertyObj = NULL;
    FREResult freResult = FREGetObjectProperty(freObject, (const uint8_t *)propertyName, &propertyObj, nil);
    
    if ( freResult == FRE_OK )
    {
        propertyValue = [ExtensionUtils boolFromFREObject:propertyObj defaultValue:defaultValue];
    }
    
    return propertyValue;
}

+ (NSString*)stringFrom:(FREObject)freObject propertyName:(const char*)propertyName defaultValue:(NSString*)defaultValue
{
    NSString* propertyValue = defaultValue;
    FREObject propertyObj = NULL;
    FREResult freResult = FREGetObjectProperty(freObject, (const uint8_t *)propertyName, &propertyObj, nil);
    
    if ( freResult == FRE_OK )
    {
        propertyValue = [ExtensionUtils stringFromFREObject:propertyObj defaultValue:defaultValue];
    }
    
    return propertyValue;
    
}

+ (NSString *)convertDataToHexString:(NSData*)data
{
    const unsigned char* bytes = (const unsigned char *)data.bytes;
    
    if ( bytes )
    {
        unsigned int nBytes = data.length;
        NSMutableString* hexData = [NSMutableString stringWithCapacity:(nBytes * 2)];
        
        for (int i = 0; i < nBytes; i++) [hexData appendFormat:@"%02x", bytes[i]];
        
        return  hexData;
    }
    
    return nil;
}

+ (void) dispatch:(FREContext)context eventType:(NSString *)type data:(NSString *)code;
{
    if ( NULL == context )
    {
        NSLog(@"ExtensionUtils.dispatch:%@ data:%@", type, code);
        return;
    }
    
    FREDispatchStatusEventAsync(context, (const uint8_t*)[code UTF8String], (const uint8_t*)[type UTF8String]);
}

+ (void) dispatch:(FREContext)context exception:(NSException *)exception fromMethod:(NSString *)methodName
{
    NSString *data = [NSString stringWithFormat:@"exception||%@||details||%@||method||%@",
                      exception.name,
                      exception.reason,
                      methodName];
    
    [ExtensionUtils dispatch:context eventType:@"UNHANDLED_EXCEPTION" data:data];
}

@end
