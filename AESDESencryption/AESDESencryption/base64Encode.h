//
//  base64Encode.h
//  AESDESencryption
//
//  Created by zzw on 16/6/27.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface base64Encode : NSObject
//nsdata转换成base64编码字符串
+(NSString *)base64StrFromData:(NSData *)data;

//把base64编码的字符串转换成nsdata
+(NSData *)dataFromBase64Str:(NSString *)base64Str;
@end
