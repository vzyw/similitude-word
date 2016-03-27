//
// Created by vzyw on 16/3/17.
// Copyright (c) 2016 vzyw. All rights reserved.
//

#import "CellController.h"
#import "Http.h"
#import "AFNetworking.h"
@interface CellController()

@end

@implementation CellController

- (IBAction)like:(id)sender {
    int  n = [self.likesNumber.text intValue];
    self.likesNumber.text =[NSString stringWithFormat:@"%d",++n];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    
}


@end