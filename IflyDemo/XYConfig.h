//  XYConfig.h
//  IflyDemo
//
//  Created by 张建军 on 15/10/29.
//  Copyright (c) 2015年 张建军. All rights reserved.
//
/**
 * 语音合成参数模型类
 *
 * @since <#1.0#>
 */

#import <Foundation/Foundation.h>

@interface XYConfig : NSObject

@property (nonatomic) NSString *speed;//语速
@property (nonatomic) NSString *volume;//音量
@property (nonatomic) NSString *pitch;//音调
@property (nonatomic) NSString *sampleRate;//采样率
@property (nonatomic) NSString *vcnName;//发音人
@property (nonatomic) NSString *engineType;//引擎类型"auto","local","cloud"
//发音角色
@property (nonatomic,strong) NSArray *vcnNickNameArray;
//发音人名称
@property (nonatomic,strong) NSArray *vcnIdentiferArray;

/**
 * 单例
 * @return  XYConfig
 *
 * @since <#1.0#>
 */
+(instancetype)shareInstance;


@end
