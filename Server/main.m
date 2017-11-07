//
//  main.m
//  Server
//
//  Created by xiushan.fan on 2017/11/6.
//  Copyright © 2017年 FanFrank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Server *server = [Server shareInstance];
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}

