//
//  Tutorial.m
//  selinawang
//
//  Created by Selina Wang on 8/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tutorial.h"

@implementation Tutorial

-(void)playGame {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}


-(void)replay {
    CCScene *mainScene = [CCBReader loadAsScene:@"Tutorial"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}


@end
