//
//  Ball.m
//  selinawang
//
//  Created by Selina Wang on 7/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Ball.h"

@implementation Ball

-(void)didLoadFromCCB {
    self.physicsBody.collisionType = @"ball";
    _coffeeEnergy = 5;
}

@end
