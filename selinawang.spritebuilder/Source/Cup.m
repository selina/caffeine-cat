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
    //self.physicsBody.collisionMask = @[@"cup"];
}

//called on every touch
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self cupTapped];
}

-(void)cupTapped {
    //changes color and loads liquid when cup is tapped
    
    if (self.isEmpty == true) {
        [self removeCup];
    }
    else if ([self.cupfill isEqualToString:@"orange"]) {
        self.isEmpty = true;
        [self loadLiquid];
        [[self animationManager] runAnimationsForSequenceNamed:@"yellow"];
    }
    else if ([self.cupfill isEqualToString:@"red"]) {
        self.cupfill = @"orange";
        [self loadLiquid];
        [[self animationManager] runAnimationsForSequenceNamed:@"orange"];
        
    }
}

//loads a ball of coffee at the position of the cup
-(void)loadLiquid {
    CCNode *liquid = [CCBReader load:@"liquid"];
    liquid.position = self.positionInPoints;
    [self.gameplayLayer.currentPhysicsNode addChild:liquid];
    
}


-(void)removeCup {
    [self.gameplayLayer.coffeeCupsOnScreen removeObject:self];
    [self removeFromParent];
    // TODO: particle effect
}

-(void)checkIfCupInGameplay {
    int x = self.positionInPoints.x;
    int y = self.positionInPoints.y;
    if ((x < self.gameplayLayer.contentNode.contentSizeInPoints.width) && (y < self.gameplayLayer.contentNode.contentSizeInPoints.height)) {
        self.didEnterGameplay = true;
    }
    else {
        self.didEnterGameplay = false; 
    }
    
}

@end
