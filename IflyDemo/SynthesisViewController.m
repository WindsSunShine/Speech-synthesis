//
//  SynthesisViewController.m
//  IflyDemo
//
//  Created by 张建军 on 15/10/29.
//  Copyright (c) 2015年 张建军. All rights reserved.
//

#import "SynthesisViewController.h"
#import <iflyMSC/iflyMSC.h>
#import "XYConfig.h"
/*
 术语定义：
 demo中合成共包含两种工作方式：
 1.边合成边播放方式，简称通用合成；
 2.uri，只合成不播放方式，简称uir合成；
 以下demo中注释将采用简称。
 */

@interface SynthesisViewController ()<IFlySpeechSynthesizerDelegate>
//文字编辑区

{
  NSString * _uriPath;
}
@property (weak, nonatomic) IBOutlet UITextField *scanfTextField;
/*!
 *  语音合成
 */

@property (nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;

@end

@implementation SynthesisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化合成参数
    [self initSynthesizer];

}
#pragma mark  初始化uri合成的音频存放路径和播放器
-(void)initPath
{
    NSString * prePath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    
    _uriPath = [prePath stringByAppendingString:@"/uri.pcm"];
    
    NSLog(@"_uriPath = = %@",_uriPath);
    
    
}

#pragma mark -  初始化合成参数
- (void)initSynthesizer
{
    XYConfig *config = [XYConfig shareInstance];
    
    if (self.iFlySpeechSynthesizer == nil) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    }
    
    //设置代理
    
    _iFlySpeechSynthesizer.delegate = self;
    
    /*!
     * IFlySpeechConstant
     *  公共常量类
     *  主要定义参数的key value值
     */
    // 参数以KVC模式设置

    //设置语速
    /*!
     *  语速
     *  范围 （0~100） 默认值:50
     *
     *  @return 语速key
     */

    [_iFlySpeechSynthesizer setParameter:config.speed forKey:[IFlySpeechConstant SPEED]];
    
    //设置音量
    /*!
     *  音量
     *  范围（0~100） 默认值:50
     *
     *  @return 音量key
     */

    [_iFlySpeechSynthesizer setParameter:config.volume forKey:[IFlySpeechConstant VOLUME]];
    
    //设置音调
    /*!
     *  音调
     *  范围（0~100）默认值:50
     *
     *  @return 音调key
     */

    [_iFlySpeechSynthesizer setParameter:config.pitch forKey:[IFlySpeechConstant PITCH]];
    
    //设置采样率
    /*!
     *  合成、识别、唤醒、评测、声纹等业务采样率。
     *
     *  @return 合成及识别采样率key。
     */

    [_iFlySpeechSynthesizer setParameter:config.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    //设置发音人
    
    [_iFlySpeechSynthesizer setParameter:config.vcnName forKey:[IFlySpeechConstant VOICE_NAME]];

    
}

#pragma mark - uri 合成



#pragma mark - 通用合成

#pragma mark 开始合成
- (IBAction)synthesisAction:(UIButton *)sender {
    
    if ([_scanfTextField.text isEqualToString:@""]) {
        
        NSLog(@"请输入有效的文本信息");
        return;
    }
   
    //设置代理
    _iFlySpeechSynthesizer.delegate = self;
    //开始语音合成并播放
    [_iFlySpeechSynthesizer startSpeaking:_scanfTextField.text];
    
    [self.scanfTextField resignFirstResponder];
}

-(BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return YES;
}

#pragma mark - IFlySpeechSynthesizerDelegate

#pragma mark 开始语音播放回调
-(void)onSpeakBegin
{
    NSLog(@"开始播放语音");
    
}

#pragma mark 语音播放完成回调
-(void)onCompleted:(IFlySpeechError *)error
{
    NSLog(@"语音播放完成");
}

#pragma mark 播放进度回调
-(void)onSpeakProgress:(int)progress
{
    NSLog(@"播放进度 == %d",progress);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
