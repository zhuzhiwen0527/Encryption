//
//  DESEncryption.h
//  AESDESencryption
//
//  Created by zzw on 16/6/27.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESEncryption : NSObject

//加密
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密
+ (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;

@end
