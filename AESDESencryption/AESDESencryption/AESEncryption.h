//
//  AESEncryption.h
//  AESDESencryption
//
//  Created by zzw on 16/6/27.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESEncryption : NSObject


//加密
+ (NSString *) encryptUseAES:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv;
//解密
+ (NSString *) decryptUseAES:(NSString*)cipherText key:(NSString*)key iv:(NSString *)iv;
@end
