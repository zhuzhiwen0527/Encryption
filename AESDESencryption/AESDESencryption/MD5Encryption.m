//
//  MD5Encryption.m
//  AESDESencryption
//
//  Created by zzw on 16/6/28.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "MD5Encryption.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation MD5Encryption
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
