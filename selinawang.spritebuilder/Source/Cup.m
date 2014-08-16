//
//  Cup.m
//  selinawang
//
//  Created by Selina Wang on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Cup.h"
#import "Gameplay.h"


@implementation Cup {
    
}

-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    self.physicsBody.collisionType = @"cup";
    
}

//called on every touch
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self cupTapped];
}

-(void)cupTapped {
    //changes color and loads liquid when cup is tapped
    
    if (self.isEmpty == true) {
      
        CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"CupSparkle"];
        explosion.autoRemoveOnFinish = true;
        explosion.position = self.positionInPoints;
        [self.gameplayLayer addChild:explosion];
        [self removeCup];
    
    }
    else if ([self.cupfill isEqualToString:@"orange"]) {
        self.isEmpty = true;
        [self loadBall];
        [[self animationManager] runAnimationsForSequenceNamed:@"yellow"];
    }
    else if ([self.cupfill isEqualToString:@"red"]) {
        self.cupfill = @"orange";
        [self loadBall];
        [[self animationManager] runAnimationsForSequenceNamed:@"orange"];
        
    }
}

//loads a ball of coffee at the position of the cup
-(void)loadBall {
    CCNode *ball = [CCBReader load:@"liquid"];
    ball.position = self.positionInPoints;
    [self.gameplayLayer.currentPhysicsNode addChild:ball];

}


-(void)removeCup {
    [self.gameplayLayer.coffeeCupsOnScreen removeObject:self];
    [self removeFromParent];
    // TODO: particle effect
}


@end
