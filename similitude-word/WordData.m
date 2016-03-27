//
//  WordData.m
//  similitude-word
//
//  Created by vzyw on 16/2/5.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import "WordData.h"


@interface WordData()

@end


@implementation WordData

static NSString * URL = @"http://114.215.154.149/similitude_word/index.php/Api/Index/index?word=";


-(WordData *)initWithWord:(NSString * )word{
    if(self = [super init]){
        [word stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSData * receive = [[[Http alloc]initWithURL:[URL stringByAppendingString:word]]asyGet];
        
        NSString *str = [[NSString alloc]initWithData:receive encoding:NSUTF8StringEncoding];
        if (!receive) {
            self->status = -2;
            return self;
        }
        [self deCodeJsonStr:str];
    }
    return self;
}

-(void)deCodeJsonStr:(NSString *)str{
    NSData  * data  = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error = nil;
    id jsonObject   = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    int statusCode = [((NSString *)jsonObject[@"status_code"]) intValue];
    
    if(statusCode == -1 || statusCode == 0){
        self->status = -1;
        return;
    }
    
    self->status = statusCode;
    NSDictionary * wordData = jsonObject[@"data"];
    
    self->wordName = wordData[@"word_name"];
    self->pr_uk    = wordData[@"pr_uk"];
    self->pr_us    = wordData[@"pr_us"];
    self->uk_mp3   = [[NSURL alloc]initWithString:wordData[@"pr_uk_mp3"]];
    self->us_mp3   = [[NSURL alloc]initWithString:wordData[@"pr_us_mp3"]];
    self->definitons = wordData[@"definitions"];
    if(statusCode==1)return;
    self->similitudeWordList = jsonObject[@"similitude_word_list"];
}


@end
