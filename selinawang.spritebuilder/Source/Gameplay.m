//
//  Gameplay.m
//  selinawang
//
//  Created by Selina Wang on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//


#import "Gameplay.h"
#import "Cup.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_coffeeCupTypeArray;
    int catEnergy;
    float randomfloat;
    CCNode *_background;
    int timeSinceStart;
    
}


- (void)didLoadFromCCB {
    // tell the scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    self.currentPhysicsNode = _physicsNode; 
    _coffeeCupTypeArray = [NSMutableArray arrayWithObjects: @"orange", @"yellow", @"red", nil];
    self.coffeeCupsOnScreen = [NSMutableArray arrayWithObjects: nil];
    
    
    [self schedule:@selector(updateCupPosition) interval:.02];
    //_physicsNode.debugDraw = true;
    _physicsNode.collisionDelegate = self; 
}

- (void)update:(CCTime)delta {
    [self generateNewCup:delta];
   
}

- (void)pause {
    CCScene *pauseScene = [CCBReader loadAsScene:@"PauseScene"];
    [[CCDirector sharedDirector] replaceScene:pauseScene];
}

-(void)generateCup{
    //generates random cup type at a random x position at the top
    
    int randomint = arc4random() % 3;
    Cup *cupinstance = (Cup*)[CCBReader load:[_coffeeCupTypeArray objectAtIndex:randomint]];
    cupinstance.cupfill = [_coffeeCupTypeArray objectAtIndex:randomint];
    
    if ([cupinstance.cupfill isEqualToString:@"yellow"]) {
        cupinstance.isEmpty = true;
    }
    else if ([cupinstance.cupfill isEqualToString:@"orange"] || [cupinstance.cupfill isEqualToString:@"red"]) {
        cupinstance.isEmpty = false;
    }
    
    srandom(time(NULL));
    
    float x = cupinstance.x_position;
    float y = cupinstance.y_position;
    
    x = CCRANDOM_0_1() * _contentNode.contentSize.width;
    y = _contentNode.contentSize.height;
    CGPoint cupLocation = ccp(x, y);
    
    cupinstance.positionType = CCPositionTypeNormalized;
    cupinstance.position = cupLocation;
    
    cupinstance.gameplayLayer = self; 
    [_physicsNode addChild:cupinstance];
    //[_contentNode addChild:cupinstance];
    
    [self.coffeeCupsOnScreen addObject:cupinstance];
}

-(void)updateCupPosition {
    //moves each cup in the array of cups on screen down
    
    for (Cup *cup in _coffeeCupsOnScreen) {
        cup.positionInPoints = ccp(cup.positionInPoints.x, (cup.positionInPoints.y - 1));
    }
}

-(void)generateNewCup:(CCTime)delta {
    //after random amount of time less than three seconds: generate new cup
    
    srandom(time(NULL));
    
    _timeSinceCup += delta;
    
    if (_timeSinceCup > randomfloat) {
        [self generateCup];
        _timeSinceCup = 0;
        randomfloat = (CCRANDOM_0_1() * 3) + 1;
    }
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(CCNode *)cat ball:(CCNode *)balloon {
    balloon.visible=NO;
    balloon.physicsBody.collisionMask=@[];
//    [[_physicsNode space] addPostStepBlock:^{
//        [self ballRemoved:balloon];
//    } key:cat];
    return NO;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(CCNode *)nodeA cup:(CCNode *)nodeB {
    return NO;
}

//-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA cup:(CCNode *)nodeB {
//    return NO;
//}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair buffer:(CCNode *)nodeA cup:(CCNode *)nodeB {
    return NO;
}

     
-(void)ballRemoved:(CCNode *)ball {
         [ball removeFromParent];
}

-(void)updateTime {
    timeSinceStart += 1; 
}



@end





