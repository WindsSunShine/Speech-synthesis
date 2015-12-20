//
//  CXYPlayer.m
//  IflyDemo
//
//  Created by 张建军 on 15/10/29.
//  Copyright (c) 2015年 张建军. All rights reserved.
//

#import "CXYPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface CXYPlayer()
{
    
}
//音频播放器
@property(nonatomic, retain)AVAudioPlayer *player;

//音频文件
@property (nonatomic,strong) NSMutableData *pcmData;


@end
@implementation CXYPlayer


-(instancetype)initPlayerWithPath:(NSString *)path sampleRate:(long)sample
{
    self = [super init];
    if (self) {
        
        NSData * audioData = [NSData dataWithContentsOfFile:path];
        [self writeWaveHead:audioData sampleRate:sample];
    }
    
    return nil;
}

-(instancetype)initPlyerWithData:(NSData *)data sampleRate:(long)sample
{
    return nil;
}

#pragma mark 写wave音频头,写完回调 onAudioLoaded 函数

- (void)writeWaveHead:(NSData *)audioData sampleRate:(long)sampleRate{
    
    
}
#pragma mark 开始播放音频
-(void)startPlay
{
    if (self.isPlaying) {
        
        NSLog(@"正在播放");
        return;
    }
    self.isPlaying = YES;
    //播放音量为1
    self.player.volume = 1;
    
    if (self.pcmData.length > 0) {
        
        BOOL play = [self.player play];
        NSLog(@"play = %d",play);
    }else
    {
        NSLog(@"音频文件是空的");
        self.isPlaying = NO;
    }
    
}



#pragma mark 停止播放音频
-(void)stop
{
    if (self.isPlaying) {
        self.isPlaying = NO;
        //停止播放
        [self.player stop];
        //当前播放时间设置为0
        self.player.currentTime = 0;
    }
}

#pragma mark - AVAudioPlayerDelegate
#pragma mark 音频播放完成调用
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    NSLog(@"音频播放完成");
    self.isPlaying = NO;
}

@end
