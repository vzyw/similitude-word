//
//  WordDetail.h
//  similitude-word
//
//  Created by vzyw on 16/2/5.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordData.h"
#import <AVFoundation/AVFoundation.h>
@interface WordDetailController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property WordData * data;
@property AVAudioPlayer * player;

@end
