//
//  AppDelegate.m
//  FRTestMachPort
//
//  Created by xiushan.fan on 2017/11/6.
//  Copyright © 2017年 FanFrank. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSMachPortDelegate> {
    NSMachPort *cport;
    NSMachPort *svrPort;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Wait for the server to be available.
    while (svrPort == nil) {
        svrPort = (NSMachPort *)[NSMachBootstrapServer.sharedInstance portForName:@"DZQ5YNVEU2.com.fan.server"];
        sleep(2);
    }
    while (svrPort.isValid) {
        cport = (NSMachPort *)[NSPort port];
        [[NSMachBootstrapServer sharedInstance] registerPort:cport name:@"DZQ5YNVEU2.com.fan.client"];
        [cport scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self monitor:nil];
    }
    NSLog(@"ossssssssk");
}

- (void)monitor:(id)sender {
    while (1) {
        NSPort *serverPort = [[NSMachBootstrapServer sharedInstance] portForName:@"DZQ5YNVEU2.com.fan.server"];
        if (serverPort.isValid && cport.isValid) {
            NSLog(@"did scan server port = %@",serverPort);
            NSData *hello = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
            NSPortMessage *portMes = [[NSPortMessage alloc] initWithSendPort:serverPort receivePort:cport components:@[hello]];
            [portMes sendBeforeDate:[NSDate dateWithTimeIntervalSinceNow:5]];
        }
        sleep(2);
    }
}

- (void)handlePortMessage:(NSPortMessage *)message {
    NSLog(@"message = %@",message);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
