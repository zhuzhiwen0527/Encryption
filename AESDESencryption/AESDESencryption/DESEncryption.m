//
//  DESEncryption.m
//  AESDESencryption
//
//  Created by zzw on 16/6/27.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "DESEncryption.h"
#import <CommonCrypto/CommonCrypto.h>
#import "base64Encode.h"
@implementation DESEncryption
/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    
    plainText = [plainText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet lowercaseLetterCharacterSet]];
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
    
  
    
        ciphertext = [base64Encode base64StrFromData:data];
        
        NSLog(@"%@",ciphertext);
    }
 
    return ciphertext;
}
//解密
+ (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    
    NSData* cipherData = [base64Encode dataFromBase64Str:cipherText];


    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    plainText = [plainText stringByRemovingPercentEncoding];
    return plainText;
}
@end
