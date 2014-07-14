//
//  Gameplay.m
//  selinawang
//
//  Created by Selina Wang on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_coffeeCupTypeArray;
    NSMutableArray *_coffeeCupPositionArray;
}


_coffeeCupTypeArray = [NSMutableArray arrayWithObjects: @"orange", @"yellow", @"red", nil];



- (void)didLoadFromCCB {
    // tell the scene to accept touches
    self.userInteractionEnabled = TRUE;
}

-(void)generateCup{
    int randomint = arc4random() % 4;
    [CCBReader load:[_coffeeCupTypeArray objectAtIndex:randomint]];
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





