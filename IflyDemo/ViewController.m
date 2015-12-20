//
//  ViewController.m
//  IflyDemo
//
//  Created by 张建军 on 15/10/12.
//  Copyright (c) 2015年 张建军. All rights reserved.
//

#import "ViewController.h"
#import "MyHeader.h"
#import <iflyMSC/IFlyMSC.h>




@interface ViewController ()<IFlySpeechRecognizerDelegate>
{
    //不带界面的识别对象
    IFlySpeechRecognizer * _iFlySpeechRecognizer;
    __weak IBOutlet UITextView *showText;
    __weak IBOutlet UILabel *voice;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
   //创建语音听写对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    
    
   //设置听写模式
    
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
   //设置存储路径 asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
    
//    [_iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    _iFlySpeechRecognizer.delegate = self;
    
    if (_iFlySpeechRecognizer != nil) {
        
        //设置语言区域 ACCENT_HENANESE（河南话） ACCENT_MANDARIN（普通话）ACCENT_CANTONESE（粤语）
        [_iFlySpeechRecognizer setParameter:[IFlySpeechConstant ACCENT_HENANESE] forKey:[IFlySpeechConstant ACCENT]];
        
        //设置语言 LANGUAGE_CHINESE（中文） LANGUAGE_CHINESE_TW（中文台湾） LANGUAGE_ENGLISH（英文）
        [_iFlySpeechRecognizer setParameter:[IFlySpeechConstant  LANGUAGE_CHINESE ] forKey:[IFlySpeechConstant LANGUAGE]];
        
    }
    
    
   
   


}

#pragma mark - IFlySpeechRecognizerDelegate Method

#pragma mark 识别结果返回代理

-(void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    
    
    //isLast 是否是最后一次  0代表最后一次
    NSLog(@"isLast == %d 是否是最后一次结果",isLast);
    
    //结果是个数组
    NSLog(@"结果 == %@",results[0]);
    
    
    if (isLast == 0) {
        //数组里包含字典
        NSDictionary *dic = results[0];
        
        //字典的Key值是我们识别的结果
        //"\U5468\U6d69\U5927\U50bb\U903c" = 100;
        NSMutableString * text = [NSMutableString string];
        
        for (NSString * key in dic) {
            
            [text appendString:key];
        }
        
        NSLog(@"会话内容是 %@",text);
        showText.text = [NSString stringWithFormat:@"%@%@",showText.text,text];

    }
}

//json 格式解析
- (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    
    //返回的格式必须为utf8的,否则发生未知错误
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:                                    [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}

#pragma mark 识别会话结束返回代理
-(void)onError:(IFlySpeechError *)errorCode
{
    /**
     * errorCode = 0 表示正常结束 非0 表示发生错误
     */
    
    NSLog(@"识别回话结束 errCode == %d",errorCode.errorCode);
    
    //销毁识别对象
//    [_iFlySpeechRecognizer destroy];
}

#pragma mark 开始识别录音回调

-(void)onBeginOfSpeech
{
    NSLog(@"开始识别录音回调");
}

#pragma mark 停止录音回调
-(void)onEndOfSpeech
{
    NSLog(@"停止录音回调");
    
}

#pragma mark 音量回调函数

-(void)onVolumeChanged:(int)volume
{
    
    NSLog(@"音量回调函数");
    
    voice.text = [NSString stringWithFormat:@"%d",volume];
}

- (IBAction)startRecognized:(UIButton *)sender {
    
    //如果正在识别
    if ([_iFlySpeechRecognizer isListening]) {
        
        //取消本次会话
        [_iFlySpeechRecognizer cancel];
    }

    //启动识别服务
    [_iFlySpeechRecognizer startListening];
    
}
- (IBAction)clearText:(UIButton *)sender {
    
    showText.text = nil;
}
/*!
 *  停止录音
 *    调用此函数会停止录音，并开始进行语音识别
 */

- (IBAction)stopRecognized:(UIButton *)sender {
    
    [_iFlySpeechRecognizer stopListening];
    
    
    
}

/*!
 *  取消本次会话
 */

- (IBAction)cancelRecognized:(UIButton *)sender {
    
    //取消会话
    [_iFlySpeechRecognizer cancel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
