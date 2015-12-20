//
//  SemanticRecognizerViewController.m
//  IflyDemo
//
//  Created by 张建军 on 15/11/13.
//  Copyright © 2015年 张建军. All rights reserved.
//

#import "SemanticRecognizerViewController.h"
#import <iflyMSC/iflyMSC.h>
@interface SemanticRecognizerViewController ()<IFlySpeechRecognizerDelegate>

//语义识别对象
@property( nonatomic, strong)IFlySpeechUnderstander * speechUnderstander;
@end

@implementation SemanticRecognizerViewController
- (IBAction)chatButtonAction:(UIButton *)sender {
    
    //同时只能进行一路会话，这次会话没有结束不能进行下一路会话，否则会报错。若有需要多次回话，请在onError回调返回后请求下一路回话。

   BOOL result = [_speechUnderstander startListening];

    NSLog(@"function == %s  line == %d  result = %d",__FUNCTION__,__LINE__,result);

}

- (void)viewDidLoad {
    [super viewDidLoad];
  //创建语义识别对象 要确保应用程序已经开通语义功能
    
    _speechUnderstander = [IFlySpeechUnderstander sharedInstance];
    
    //设置代理
    _speechUnderstander.delegate = self;
    
    
  
    
}


-(void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
        NSLog(@" function == %s, line == %d",__FUNCTION__,__LINE__);
}


-(void)onError:(IFlySpeechError *)errorCode
{
        NSLog(@" function == %s, line == %d, error == %@",__FUNCTION__,__LINE__,errorCode);
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
