//
//  Cat.m
//  selinawang
//
//  Created by Selina Wang on 7/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Cat.h"
#import "Gameplay.h"

@implementation Cat {
    
}

-(void)didLoadFromCCB {
    self.physicsBody.collisionType = @"cat";
    [self schedule:@selector(speedUpCat) interval:20];
}

-(void)speedUpCat {
    //every twenty seconds, cat gets .1 faster
    float speedIncrease = 1.1;
    [self.gameplayLayer animationManager].playbackSpeed *= speedIncrease;
    
}


@end
