//
//  AddWordController.m
//  similitude-word
//
//  Created by vzyw on 16/3/19.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import "AddWordController.h"
#import "WordData.h"
#import "WordDetailController.h"
#import "Http.h"
#import "Message.h"
@interface AddWordController()

@end
@implementation AddWordController
-(void)viewDidLoad{
    self.seachBox.delegate=self;
    self.wordTitleBar.title = self.word;
    [self.seachBox becomeFirstResponder];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString * word = textField.text;
    if([word isEqualToString:@""])return NO;
    [self.seachBox resignFirstResponder];

    WordData * wordData = [[WordData alloc]initWithWord:word];
    
    NSString *message=nil;
    switch (wordData->status) {
        case -1:
            message = @"找不到这个单词";
            break;
        case -2:
            message = @"服务器错误,稍后再试";
            break;
        default:
            break;
    }
    if(message){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[@"确定要添加单词" stringByAppendingString:wordData->wordName]preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){
        NSString * url = [NSString stringWithFormat:@"http://114.215.154.149/similitude_word/index.php/Api/Add/index?word=%@&s_word=%@&tags_id=%@",self.word,wordData->wordName,@""];
        NSLog(@"%@",url);
        NSData * receive = [[[Http alloc]initWithURL:[url stringByAppendingString:word]]asyGet];
        if(receive){
            [Message showMessage:@"添加成功"];
        }else{
            [Message showMessage:@"添加失败,请稍后再试"];
        }
        
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    return YES;
}


@end
