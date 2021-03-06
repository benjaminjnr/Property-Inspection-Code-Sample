//
//  EKNEKNGlobalInfo.m
//  EdKeyNote
//
//  Created by canviz on 9/24/14.
//  Copyright (c) 2014 canviz. All rights reserved.
//

#import "EKNEKNGlobalInfo.h"

@interface EKNEKNGlobalInfo ()

@end

@implementation EKNEKNGlobalInfo

/*Convert UTC string to UTC date*/
+(NSDate *)converDateFromString:(NSString *)stringdate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setLocale:[NSLocale systemLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSDate *ret =[formatter dateFromString:stringdate];
    return ret;
}

+(NSString *)converUTCStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"MM'/'dd'/'yy"];
    NSString *ret =[formatter stringFromDate:date];
    return ret;
}

+(NSString *)converLocalStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    [formatter setDateFormat:@"MM'/'dd'/'yy"];
    NSString *ret =[formatter stringFromDate:date];
    return ret;
}
/*UTC string to local string*/
+(NSString *)converStringToDateString:(NSString *)stringDate
{
    NSString *result = @"";
    if(![self isBlankString:stringDate])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM'/'dd'/'yyyy"];
        
        NSDate *date = [self converDateFromString:stringDate];
        dateFormat.timeZone = [NSTimeZone systemTimeZone];
        result = [dateFormat stringFromDate:date];
    }
    
    return result;
}

+(BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(CGSize)getSizeFromStringWithFont:(NSString *)string font:(UIFont *)font
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [string sizeWithAttributes:attributes];
    return size;
}

+(NSString *)getString:(NSString *)string
{
    NSString *result = @"";
    if(![self isBlankString:string])
    {
        return string;
    }
    return  result;
}
+(BOOL)requestSuccess:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSInteger statusCode = [httpResponse statusCode];
    if(statusCode >= 200 && statusCode <= 206)
    {
        return YES;
    }
    return NO;
}
+(NSString *)getSiteUrl{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    return [standardUserDefaults objectForKey:@"demoSiteCollectionUrl"];
}

+(NSString *)createFileName:(NSString *)fileExtension
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyMMddHHmmssSSSSSS"];
    
    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableString *randstr = [[NSMutableString alloc]init];
    for(int i = 0 ; i < 5 ; i++)
    {
        int val= arc4random()%10;
        [randstr appendString:[NSString stringWithFormat:@"%d",val]];
    }
    NSString *string = [NSString stringWithFormat:@"%@%@%@",datestr,randstr,fileExtension];
    return string;
}
+(void)openUrl:(NSString *)url{
    if(url !=nil){
        NSURL *desUrl = [[NSURL alloc] initWithString:url];
        if([[UIApplication sharedApplication] canOpenURL:desUrl]){
            [[UIApplication sharedApplication] openURL:desUrl];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Open Url Fialed, please check your URL" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
}
+(NSDictionary*)parseResponseDataToDic:(NSData *)data{
    
    NSString * dataString = [[NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"dataString:%@",dataString);
    NSString* replacedDataString = [dataString stringByReplacingOccurrencesOfString:@"E+308" withString:@"E+127"];
    NSData* bytes = [replacedDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSError *error ;
    NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:bytes
                                                               options: NSJSONReadingMutableContainers
                                                                 error:&error];
    return jsonResult;
}
+(NSArray*)parseResponseDataToArray:(NSData *)data{
    
    NSString * dataString = [[NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"dataString:%@",dataString);
    NSString* replacedDataString = [dataString stringByReplacingOccurrencesOfString:@"E+308" withString:@"E+127"];
    NSData* bytes = [replacedDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSError *error ;
    NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:bytes
                                                               options: NSJSONReadingMutableContainers
                                                                 error:&error];
    if(jsonResult != nil){
        NSArray *retArray = [jsonResult objectForKey:@"value"];
        if(retArray != nil){
            return retArray;
        }
    }
    return nil;
}

+(NSString *)getGraphBetaResourceUrl{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    return [standardUserDefaults objectForKey:@"graphBetaResourceUrl"];
}
+(NSString *)getGraphResourceUrl{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    return [standardUserDefaults objectForKey:@"graphResourceUrl"];
}
+(NSString *)getAuthority{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString * authority =[standardUserDefaults objectForKey:@"authority"];
    return authority;
}
+(NSString *)getDemoSiteServiceResourceId{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *demoSiteServiceResourceId = [standardUserDefaults objectForKey:@"demoSiteServiceResourceId"];
    return demoSiteServiceResourceId;
}
+(NSString *)getOutlookResourceId{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *outlookResourceId = [standardUserDefaults objectForKey:@"outlookResourceId"];
    return outlookResourceId;
}

@end

