//
//  Gameplay.m
//  selinawang
//
//  Created by Selina Wang on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//


#import "Gameplay.h"
#import "Cup.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_coffeeCupTypeArray;
    int catEnergy;
    float randomfloat;
    CCNode *_background;
    
}


- (void)didLoadFromCCB {
    // tell the scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    _coffeeCupTypeArray = [NSMutableArray arrayWithObjects: @"orange", @"yellow", @"red", nil];
    self.coffeeCupsOnScreen = [NSMutableArray arrayWithObjects: nil];
    
    
    [self schedule:@selector(updateCupPosition) interval:.02];
    //_physicsNode.debugDraw = true;
}

- (void)update:(CCTime)delta {
    [self generateNewCup:delta];
   
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
    
    [self.coffeeCupsOnScreen addObject:cupinstance];
//    [_coffeeCupBoundingBoxArray addObject:cupinstance boundingBox];
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





// called on every touch
//- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//    CGPoint touchLocation = [touch locationInNode:_contentNode];
//    NSLog(@"gameplay touchBegan");
//}








@end





