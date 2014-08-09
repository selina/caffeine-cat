//
//  Tutorial.m
//  selinawang
//
//  Created by Selina Wang on 8/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tutorial.h"
#import "Gameplay.h"

@implementation Tutorial





-(void)play {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}



@end
