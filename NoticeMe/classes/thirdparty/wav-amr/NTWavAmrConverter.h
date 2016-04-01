//
//  VoiceConverter.h
//  Jeans
//
//  Created by Jeans Huang on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTWavAmrConverter : NSObject

+ (int)isMP3File:(NSString *)filePath;

+ (int)isAMRFile:(NSString *)filePath;

+ (int)convertAmrAtPath:(NSString *)amrPath toWavAtPath:(NSString *)wavPath;

+ (int)convertWavAtPath:(NSString *)wavPath toAmrAtPath:(NSString *)amrPath;

@end
