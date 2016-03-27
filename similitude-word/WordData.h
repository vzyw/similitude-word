//
//  WordData.h
//  similitude-word
//
//  Created by vzyw on 16/2/5.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Http.h"
@interface WordData : NSObject{
@public
    int status;
    NSString * wordName;
    NSString * pr_uk;
    NSString * pr_us;
    NSURL * uk_mp3;
    NSURL * us_mp3;
    NSString * definitons;
    NSArray * similitudeWordList;
}
-(id)initWithWord:(NSString *)word;
@end

