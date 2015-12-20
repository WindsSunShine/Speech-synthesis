//
//  CXYPlayer.h
//  IflyDemo
//
//  Created by 张建军 on 15/10/29.
//  Copyright (c) 2015年 张建军. All rights reserved.
//

/************
 暂时先不用
 *************/

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
/**
 * 音频播放器
 *
 * @since <#1.0#>
 */
@interface CXYPlayer : NSObject<AVAudioPlayerDelegate>
//是否正在播放
@property(nonatomic, assign)BOOL isPlaying;

/**
 * 初始化音频播放器，并传入音频的本地路径
 * path 音频pcm文件完整路径
 * sample 音频pcm文件采样率，支持8000 和 16000两种
 * @since <#1.0#>
 */
-(instancetype)initPlayerWithPath:(NSString *)path sampleRate:(long)sample;



/**
 * 初始化音频播放器，传入音频数据
 * data 音频数据
 * sample 音频pcm文件采样率，支持 8000 和 16000两种
 * @since <#1.0#>
 */
-(instancetype)initPlyerWithData:(NSData *)data sampleRate:(long)sample;

/**
 * 开始播放音频
 *
 * @since <#1.0#>
 */

-(void)startPlay;

/**
 * 停止播放音频
 *
 * @since <#1.0#>
 */

-(void)stop;


@end
