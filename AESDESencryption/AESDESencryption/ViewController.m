//
//  ViewController.m
//  AESDESencryption
//
//  Created by zzw on 16/6/27.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ViewController.h"
#import "DESEncryption.h"
#import "AESEncryption.h"
#import "MD5Encryption.h"
#import "RSAEncryption.h"


#define PriKey @"MIICXQIBAAKBgQCoWXDUMLNt+Tk+zltQ97vwEKuji4Y2SiSswhOO6FYVshWJ3tdn"\
"vP9EUqAIMMS4WW++J6fMcrrDaMUE2MeP6ddAqgKQjWZxoDDSKcG5+DIrlrSzbo6J"\
"3yGO1OkuxRlDi+vqhqs1s0pznLOSDOsMpJZpQjBKY+fxxSK2OFXc/yx+IQIDAQAB"\
"AoGAe4ovFzep5JEYZjOOpWs2umOxYPG5ist8AF7ndV6gFYm67pLeJd12wc+Uao5H"\
"PjU7oCJ/q7OhxFZ1BiqCv+RNNZBxHsMQxM8fhmMkquOY7iQW8o20S8nsrDcWSuDj"\
"UTnOv85RF5ICp9CeQ+eE8xo2Ww4DYdD7UEf0ATh7+cws98UCQQDd025Dx6K+emTY"\
"cuaUJ47PAnDSSt4SIqZcg4mUR7ufeOu23G02/rwb0k9jRslas5YHF6mnHa1vHUVC"\
"yIsmwk1TAkEAwkj0byD7tnYXHPHwWhf8OMG9zuiJ0qACL+USv4W0NIXk5iCxwtG6"\
"50SNoL4J9tK8zu4bxvIbvGW6emcllsckOwJAD7Oqp3OXKoKBZuzjM3OFYVPb5pbU"\
"F1aKjhvlfjCBsG0fykbaGD151UJSykU1dY0mvoPHR4QLRcU9pNeLOggg7wJBAICg"\
"hlwwrRWu9zxtnWA4cv8snbqnz9+HmgsVkSUFozoGz3XgfW/rJN/KTi32w2gLO3+Q"\
"uwkq71v6ycwSEBvT+lMCQQDMdI6ihUTUzJNbbVLcSgibVGrqBr0bFgd0RoTlCOK6"\
"lGoHMRgCGop9PlVnK89XfotVFSxF5nA59l4fmRbv/ky+"

#define PubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCoWXDUMLNt+Tk+zltQ97vwEKuj"\
"i4Y2SiSswhOO6FYVshWJ3tdnvP9EUqAIMMS4WW++J6fMcrrDaMUE2MeP6ddAqgKQ"\
"jWZxoDDSKcG5+DIrlrSzbo6J3yGO1OkuxRlDi+vqhqs1s0pznLOSDOsMpJZpQjBK"\
"Y+fxxSK2OFXc/yx+IQIDAQAB"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * str = @"中国";
    
    //DES加解密
    NSString * encrytionDES= [DESEncryption encryptUseDES:str key:@"key"];
    NSLog(@"%@",encrytionDES);
    NSLog(@"DES：%@",[DESEncryption decryptUseDES:encrytionDES key:@"key"]);
    
    //AES128加解密
    NSString * encrytionAES= [AESEncryption encryptUseAES:str key:@"key" iv:@"iv"];
    NSLog(@"%@",encrytionAES);
    NSLog(@"AES：%@",[AESEncryption decryptUseAES:encrytionAES key:@"key" iv:@"iv"]);
    //MD5加密
    NSString * encrytionMD5 = [MD5Encryption md5:str];
    
    NSLog(@"MD5:%@",encrytionMD5);
    
    //RSA加密
    
    RSAEncryption * rsa = [[RSAEncryption alloc] init];
    NSLog(@"encryptor using rsa");
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
//    NSLog(@"public key: %@", publicKeyPath);
    [rsa loadPublicKeyFromFile:publicKeyPath];
    
    NSString *securityText = str;
    NSString *encryptedString = [rsa rsaEncryptString:securityText];
    NSLog(@"encrypted data: %@", encryptedString);
    
    NSLog(@"decryptor using rsa");
    //rsa解密
    NSLog(@"%@",[[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"] );
    [rsa loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"] password:@"12345"];
    NSString *decryptedString = [rsa rsaDecryptString:encryptedString];
    NSLog(@"decrypted data: %@", decryptedString);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
