//
//  Http.h
//  similitude-word
//
//  Created by vzyw on 16/2/5.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Http : NSObject{

@private
    NSURL           * URL;
    NSURLRequest    * request;
    NSData          * received;
}
-(Http *)initWithURL:(NSString *)URL;
-(NSData *)synPost;
-(NSData *)synGet;
-(NSData *)asyPost:(NSDictionary *)data;
-(NSData *)asyGet;
@end
