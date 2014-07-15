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
    NSMutableArray *_coffeeCupPositionArray;
    NSMutableArray *_coffeeCupsOnScreen;
    int catEnergy;
    float randomfloat;
    
}


- (void)didLoadFromCCB {
    // tell the scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    _coffeeCupTypeArray = [NSMutableArray arrayWithObjects: @"orange", @"yellow", @"red", nil];
    _coffeeCupsOnScreen = [NSMutableArray arrayWithObjects: nil];
    
    [self schedule:@selector(updateCupPosition) interval:1];
   
}

- (void)update:(CCTime)delta {
    [self generateNewCup:delta];
   
}

-(void)generateCup{
    //generates random cup type at a random x position at the top
    
    int randomint = arc4random() % 3;
    Cup *cupinstance = (Cup*)[CCBReader load:[_coffeeCupTypeArray objectAtIndex:randomint]];
    
    srandom(time(NULL));
    
    float x = cupinstance.x_position;
    float y = cupinstance.y_position;
    
    x = CCRANDOM_0_1() * _contentNode.contentSize.width;
    y = _contentNode.contentSize.height;
    CGPoint cupLocation = ccp(x, y);
    
    cupinstance.positionType = CCPositionTypeNormalized;
    cupinstance.position = cupLocation;
    
    [self addChild:cupinstance];
    
    [_coffeeCupsOnScreen addObject:cupinstance];
}

-(void)updateCupPosition {
    //moves each cup in the array of cups on screen down
    
    for (Cup *cup in _coffeeCupsOnScreen) {
        cup.positionInPoints = ccp(cup.positionInPoints.x, (cup.positionInPoints.y - 50));
    }
}

-(void)generateNewCup:(CCTime)delta {
    //after random amount of time less than three seconds: generate new cup
    
    srandom(time(NULL));
    
    timeSinceCup += delta;
    
    if (timeSinceCup > randomfloat) {
        [self generateCup];
        timeSinceCup = 0;
        randomfloat = (CCRANDOM_0_1() * 3) + 1;
    }
}


- (void)removeCup {
    
    [_coffeeCupsOnScreen removeObject:self];
    [self removeFromParent];
    
    
    // TODO: particle effect
}


// called on every touch
//- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//    CGPoint touchLocation = [touch locationInNode:_contentNode];
//    if (touchLocation in _coffeeCupPositionArray) {
//        
//    }
//    else {
//        pass;
//    }
//}

- (void)cupTapped {
    
}

//randomized background color:

//CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
//CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
//CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
//UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
//




@end





