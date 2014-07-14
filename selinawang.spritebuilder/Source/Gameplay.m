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
    
}





- (void)didLoadFromCCB {
    // tell the scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    _coffeeCupTypeArray = [NSMutableArray arrayWithObjects: @"orange", @"yellow", @"red", nil];
    [self generateCup];
}

-(void)generateCup{
    //generate random cup type (empty, half full, or full)
    
    int randomint = arc4random() % 3;
    Cup *cupinstance = (Cup*)[CCBReader load:[_coffeeCupTypeArray objectAtIndex:randomint]];
    
    srandom(time(NULL));
    
    CGFloat x_position = CCRANDOM_0_1() * _contentNode.contentSize.width;
    float y_position = _contentNode.contentSize.height;
    CGPoint cupLocation = ccp(x_position, y_position);
    
    cupinstance.positionType = CCPositionTypeNormalized;
    cupinstance.position = cupLocation;
    
    [self addChild:cupinstance];
}

-(void)update:(CCTime)delta {
    //check for how much time has passed to see if it's time to generate new cup
    
    
    
    //move cups down by increment 
    
}
- (void)removeCup {
    [self removeFromParent];
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





