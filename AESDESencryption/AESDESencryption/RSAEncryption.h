//
//  RSAEncryption.h
//  AESDESencryption
//
//  Created by zzw on 16/6/28.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncryption : NSObject

#pragma mark - Instance Methods

-(void) loadPublicKeyFromFile: (NSString*) derFilePath;
-(void) loadPublicKeyFromData: (NSData*) derData;

-(void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password;
-(void) loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password;




-(NSString*) rsaEncryptString:(NSString*)string;
-(NSData*) rsaEncryptData:(NSData*)data ;

-(NSString*) rsaDecryptString:(NSString*)string;
-(NSData*) rsaDecryptData:(NSData*)data;

-(BOOL) rsaSHA1VerifyData:(NSData *) plainData
            withSignature:(NSData *) signature;



#pragma mark - Class Methods

+(void) setSharedInstance: (RSAEncryption*)instance;
+(RSAEncryption*) sharedInstance;
@end
