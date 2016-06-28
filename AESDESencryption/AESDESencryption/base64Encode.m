//
//  base64Encode.m
//  AESDESencryption
//
//  Created by zzw on 16/6/27.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "base64Encode.h"

@implementation base64Encode
+(NSString *)base64StrFromData:(NSData *)data{
    return [self encode:(const uint8_t*) data.bytes length:data.length];
}

+(NSData *)dataFromBase64Str:(NSString *)base64Str{
    return [self decode:[base64Str cStringUsingEncoding:NSASCIIStringEncoding] length:base64Str.length];
}


#pragma mark - 具体实现 -
//这是一个静态的char数组，
static char decodingTable[128];

#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))

+ (void) initialize
{
    //一串char数组，用来初始化efunDecodingTable
    char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    if (self == [base64Encode class])
    {
        //把char 数组清零
        memset(decodingTable, 0, ArrayLength(decodingTable));
        //利用 encodingTable，循环初始化，efunDecodingTable 数组的一部分char，值是xxx
        for (NSInteger i = 0; i < ArrayLength(encodingTable); i++)
        {
            decodingTable[encodingTable[i]] = i;
        }
    }
}

+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length
{
    char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    // 声明一个可变的OC数据
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    //uint8_t 你会发现是一个unsign char；但是，这里还有一个*
    uint8_t * output = (uint8_t*)data.mutableBytes;
    
    //注意这个循环，每次跳跃仨
    for (NSInteger i = 0; i < length; i += 3)
    {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++)
        {
            value <<= 8;
            
            if (j < length)
            {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    encodingTable[(value >> 18) & 0x3F];
        output[index + 1] =                    encodingTable[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? encodingTable[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? encodingTable[(value >> 0)  & 0x3F] : '=';
    }
    //他妈，之前没有autorelease，函数返回值，一定记得autorelease，内存不能坑爹有木有
    return [[[NSString alloc] initWithData:data
                                  encoding:NSASCIIStringEncoding]autorelease];
}


+ (NSData*) decode:(const char*) string length:(NSInteger) inputLength
{
    //如果字符串为空，或者长度不是4的整数倍，直接返回空。
    if ((string == NULL) || (inputLength % 4 != 0)) {
        return nil;
    }
    //去掉字符串后面的所有“＝”
    while (inputLength > 0 && string[inputLength - 1] == '=') {
        inputLength--;
    }
    
    NSInteger outputLength = inputLength * 3 / 4;
    NSMutableData* data = [NSMutableData dataWithLength:outputLength];
    uint8_t* output = data.mutableBytes;
    
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < inputLength)
    {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A';
        char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';
        output[outputPoint++] = (decodingTable[i0] << 2) | (decodingTable[i1] >> 4);
        if (outputPoint < outputLength)
        {
            output[outputPoint++] = ((decodingTable[i1] & 0xf) << 4) | (decodingTable[i2] >> 2);
        }
        if (outputPoint < outputLength)
        {
            output[outputPoint++] = ((decodingTable[i2] & 0x3) << 6) | decodingTable[i3];
        }
    }
    return data;
}

@end
