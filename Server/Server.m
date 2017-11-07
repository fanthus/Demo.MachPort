//
//  Server.m
//  Server
//
//  Created by xiushan.fan on 2017/11/6.
//  Copyright © 2017年 FanFrank. All rights reserved.
//

#import "Server.h"



static Server *server = nil;

@interface Server()<NSMachPortDelegate> {
    NSMachPort *sport;
}

@end

@implementation Server

+ (id)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        server = [[Server alloc] init];
    });
    return server;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        sport = (NSMachPort *)[NSPort port];
        sport.delegate = self;
        [[NSMachBootstrapServer sharedInstance] registerPort:sport name:@"DZQ5YNVEU2.com.fan.server"];
        [sport scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        NSThread *th  = [[NSThread alloc] initWithTarget:self selector:@selector(monitor:) object:nil];
        [th start];
    }
    return self;
}

- (void)monitor:(id)sender {
    while (![NSThread currentThread].isCancelled) {
        NSPort *clientPort = [[NSMachBootstrapServer sharedInstance] portForName:@"DZQ5YNVEU2.com.fan.client"];
        if (clientPort) {
            //            NSData *hello = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
            //            NSPortMessage *portMes = [[NSPortMessage alloc] initWithSendPort:sport receivePort:clientPort components:@[hello]];
            //            [portMes sendBeforeDate:[NSDate distantFuture]];
        }
        sleep(2);
    }
}

- (void)handlePortMessage:(NSPortMessage *)message {
    NSLog(@"mess %@",[[NSString alloc] initWithData:message.components[0] encoding:NSUTF8StringEncoding]);
}

@end

