//
//  AESEncryption.m
//  AESDESencryption
//
//  Created by zzw on 16/6/27.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "AESEncryption.h"
#import <CommonCrypto/CommonCrypto.h>
#import "base64Encode.h"
@implementation AESEncryption
//加密
+ (NSString *) encryptUseAES:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv{
  
    plainText = [plainText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet uppercaseLetterCharacterSet]];
    NSData * data = [plainText dataUsingEncoding:NSUTF8StringEncoding];

    return [base64Encode base64StrFromData:[self AES128Operation:kCCEncrypt data:data key:key iv:iv]];

}

//解密
+ (NSString *) decryptUseAES:(NSString*)cipherText key:(NSString*)key iv:(NSString *)iv{
    
        NSData * data = [base64Encode dataFromBase64Str:cipherText];
  
    return [[[NSString alloc] initWithData:[self AES128Operation:kCCDecrypt data:data key:key iv:iv] encoding:NSUTF8StringEncoding] stringByRemovingPercentEncoding];
}


+ (NSData *)AES128Operation:(CCOperation)operation data:(NSData*)data key:(NSString *)key iv:(NSString *)iv
{
    //一个char数组，kCCKeySizeAES128 ＝ 16
    char keyPtr[kCCKeySizeAES128 + 1];
    //把数组全部设置为0，
    memset(keyPtr, 0, sizeof(keyPtr));
    //把NSString存放到字符数组里面，字符数组最多是16位
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    //创建一个字符数组，kCCBlockSizeAES128 ＝ 16
    char ivPtr[kCCBlockSizeAES128 + 1];
    //把字符数组全部值为 0
    memset(ivPtr, 0, sizeof(ivPtr));
    //把NSString 放进字符数组里面，最多16位 17位的话，最后一个不晓得要不要存放"\0"
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    //取出要加密的数据的长度
    NSUInteger dataLength = [data length];
    //把该长度加上 kCCBlockSizeAES128 ＝ 16
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    //从内存中开辟一个bufferSize大小的空间，指针给buffer （void *） 任意类型
    void * buffer = malloc(bufferSize);
    
    //numBytesCrypted 接收加密解密后的数据的长度
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          //kCCKeySizeAES256->kCCAlgorithmBlowfish;
//                                          kCCBlockSizeAES128->kCCAlgorithmAES128;
                                          kCCAlgorithmAES128,
//                                          kCCKeySize3DES->kCCAlgorithm3DES
//                                          kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
//                                                                                    kCCBlockSizeAES128,
                                          //                                          kCCKeySizeAES256,
//                                          kCCKeySize3DES,
                                          kCCKeySizeAES128 ,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess)
    {
        //注意，此时的buffer是一个局部变量
        NSData * cryptData=[NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        //这里的buffer没有free哦
        return cryptData;
    }
    //buffer是malloc出来的，要释放掉
    free(buffer);
    return nil;
}
@end
