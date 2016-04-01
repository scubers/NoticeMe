//
//  VoiceConverter.m
//  Jeans
//
//  Created by Jeans Huang on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NTWavAmrConverter.h"
#import "wav.h"
#import "interf_dec.h"
#import "dec_if.h"
#import "interf_enc.h"
#import "amrFileCodec.h"

@implementation NTWavAmrConverter


+ (int)isMP3File:(NSString *)filePath{
    const char *_filePath = [filePath cStringUsingEncoding:NSASCIIStringEncoding];
    return isMP3File(_filePath);
}

+ (int)isAMRFile:(NSString *)filePath{
    const char *_filePath = [filePath cStringUsingEncoding:NSASCIIStringEncoding];
    return isAMRFile(_filePath);
}

+ (int)convertAmrAtPath:(NSString *)amrPath toWavAtPath:(NSString *)wavPath
{
    return !convertAmrToWav([amrPath cStringUsingEncoding:NSASCIIStringEncoding],
                            [wavPath cStringUsingEncoding:NSASCIIStringEncoding]);
}

+ (int)convertWavAtPath:(NSString *)wavPath toAmrAtPath:(NSString *)amrPath;
{
    return !convertWavToAmr([wavPath cStringUsingEncoding:NSASCIIStringEncoding],
                            [amrPath cStringUsingEncoding:NSASCIIStringEncoding], 1, 16);
}
    
    
@end
