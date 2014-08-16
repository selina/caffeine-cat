//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Cup.h"

@implementation MainScene {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_coffeeCupTypeArray;
    float randomfloat;
    int timeSinceCup;
    }


- (void)didLoadFromCCB {
    // tell the scene to accept touches
    self.userInteractionEnabled = TRUE;
    _coffeeCupTypeArray = [NSMutableArray arrayWithObjects: @"orange", @"orange", @"yellow", @"red", @"red", nil];
    
    [self schedule:@selector(generateCup) interval:2]; 

    }

-(void)generateCup{
    //generates random cup type at a random x position at the top
    
    int randomint = arc4random_uniform(5);
    Cup *cupinstance = (Cup*)[CCBReader load:[_coffeeCupTypeArray objectAtIndex:randomint]];
    
    
    srandom(time(NULL));
    
    float contentNodeWidth = _contentNode.contentSize.width;
    
    float x = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.8);
    float y = _contentNode.contentSize.height;
    CGPoint cupLocation = ccp(x, y);
    
    cupinstance.positionType = CCPositionTypeNormalized;
    cupinstance.position = cupLocation;
   
    
    [_physicsNode addChild:cupinstance];
    
    cupinstance.physicsBody.velocity = ccp(0, -80);
}



-(void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene]; 
}

-(void)settings {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Settings"];
    [[CCDirector sharedDirector] pushScene:gameplayScene];
}

-(void)tutorial {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Tutorial"];
    [[CCDirector sharedDirector] pushScene:gameplayScene];

}

@end
