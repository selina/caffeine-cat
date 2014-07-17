//
//  Cup.m
//  selinawang
//
//  Created by Selina Wang on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Cup.h"
#import "Gameplay.h"


@implementation Cup

-(void)didLoadFromCCB {
    self.userInteractionEnabled = true; 
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self removeCup];
}

-(void)removeCup {
    
    if ([self.cupcolor isEqualToString: @"yellow"]) {
        [self.gameplayLayer.coffeeCupsOnScreen removeObject:self];
        [self removeFromParent];

    }
    
    
    // TODO: particle effect
}

@end
