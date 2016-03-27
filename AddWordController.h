//
//  AddWordController.h
//  similitude-word
//
//  Created by vzyw on 16/3/19.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import "ViewController.h"

@interface AddWordController : ViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *wordTitleBar;

@property (weak, nonatomic) IBOutlet UITextField *seachBox;

@property NSString * word;
@end
