//
//  Http.m
//  similitude-word
//
//  Created by vzyw on 16/2/5.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import "Http.h"

@implementation Http
-(Http *)initWithURL:(NSString *)url{
    URL = [NSURL URLWithString:url];
    return self;
}
-(NSData *)synPost{

    return nil;
}
-(NSData *)synGet{//todo
    return nil;
}
-(NSData *)asyPost:(NSString *)word :(NSString *)s_word{
    return nil;
}
-(NSData *)asyGet{
    NSError * e=nil;
    request = [[NSURLRequest alloc]initWithURL:self->URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2];
    received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&e];
    if(e)return nil;
    return received;
}


@end
