//
//  ViewController.m
//  similitude-word
//
//  Created by vzyw on 16/2/4.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import "ViewController.h"
#import "WordDetailController.h"
#import "WordData.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UITextField *searchBox;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBox.frame = CGRectMake(0, 0, self.view.frame.size.width-80, 30);
    [self.searchBox becomeFirstResponder];
    [self.searchBox setDelegate:self];
    self.searchBox.text = @"hello";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString * word = textField.text;
    if([word isEqualToString:@""])return NO;

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
    [self.searchBox resignFirstResponder];
    [self performSegueWithIdentifier:@"toWordDetailView" sender:wordData];
    return YES;
}


//触摸空白处关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView  *view = (UIView *)[touch view];
    if (view == self.view) {
        [self.searchBox resignFirstResponder];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toWordDetailView"]) {
        WordDetailController * wordDetailView = segue.destinationViewController;
        wordDetailView.originalData = sender;
    }
    
}

@end
