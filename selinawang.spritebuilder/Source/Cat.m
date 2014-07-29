//
//  Cat.m
//  selinawang
//
//  Created by Selina Wang on 7/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Cat.h"

@implementation Cat {
    
}

-(void)didLoadFromCCB {
    self.physicsBody.collisionType = @"cat";
}

-(void)speedUpCat {
    [self animationManager].playbackSpeed = 0.4;
}


@end
