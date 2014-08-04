//
//  Gameplay.m
//  selinawang
//
//  Created by Selina Wang on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//


#import "Gameplay.h"
#import "Cup.h"
#define CP_ALLOW_PRIVATE_ACCESS 1
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Cat.h"
#import "Ball.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_coffeeCupTypeArray;
    int catEnergy;
    float randomfloat;
    CCNode *_background;
    int timeSinceStart;
    CCLabelTTF *_timeLabel;
    CCNode *_scorebar;
    float energy;
    float totalEnergy;
    Cat *_cat;
    
}


- (void)didLoadFromCCB {
    // tell the scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.contentNode = _contentNode; 
    self.currentPhysicsNode = _physicsNode; 
    _coffeeCupTypeArray = [NSMutableArray arrayWithObjects: @"orange", @"yellow", @"red", nil];
    self.coffeeCupsOnScreen = [NSMutableArray arrayWithObjects: nil];
    _cat.gameplayLayer = self; 
    
//    [self schedule:@selector(updateCupPosition) interval:.01];
    [self schedule:@selector(updateTime) interval:1];
    [self schedule:@selector(loseEnergyIncrementally) interval:.1];
    //_physicsNode.debugDraw = true;
    _physicsNode.collisionDelegate = self;
    totalEnergy = 100;
    energy = 100;
}

- (void)update:(CCTime)delta {
    [self generateNewCup:delta];
   
}

static void
cupUpdateVelocity(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt)
{
    cpAssertSoft(body->m > 0.0f && body->i > 0.0f, "Body's mass and moment must be positive to simulate. (Mass: %f Moment: %f)", body->m, body->i);
    
//    body->v = cpvadd(cpvmult(body->v, damping), cpvmult(cpvmult(body->f, body->m_inv), dt));
//	body->w = body->w*damping + body->t*body->i_inv*dt;
    
	// Reset forces.
	body->f = cpvzero;
	body->t = 0.0f;
    
    //change this number for speed the blocks fall at
    int randomint = arc4random_uniform(40) + 80;
	body->v.y = -1 * randomint;
}

- (void)pause {
    CCScene *pauseScene = [CCBReader loadAsScene:@"PauseScene"];
    [[CCDirector sharedDirector] pushScene:pauseScene];
}

-(void)generateCup{
    //generates random cup type at a random x position at the top
    
    int randomint = arc4random_uniform(3);
    Cup *cupinstance = (Cup*)[CCBReader load:[_coffeeCupTypeArray objectAtIndex:randomint]];
    cupinstance.physicsBody.body.body->velocity_func = cupUpdateVelocity;
    cupinstance.cupfill = [_coffeeCupTypeArray objectAtIndex:randomint];
    
    
    
    if ([cupinstance.cupfill isEqualToString:@"yellow"]) {
        cupinstance.isEmpty = true;
    }
    else if ([cupinstance.cupfill isEqualToString:@"orange"] || [cupinstance.cupfill isEqualToString:@"red"]) {
        cupinstance.isEmpty = false;
    }
    
    srandom(time(NULL));
    
//    float x = cupinstance.x_position;
//    float y = cupinstance.y_position;
    
    float x = CCRANDOM_0_1() * _contentNode.contentSize.width;
    float y = _contentNode.contentSize.height;
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
        [cup checkIfCupInGameplay]; 
    }
}

-(void)generateNewCup:(CCTime)delta {
    //after random amount of time less than three seconds: generate new cup
    
    srandom(time(NULL));
    
    _timeSinceCup += delta;
    
    if (_timeSinceCup > randomfloat) {
        [self generateCup];
        _timeSinceCup = 0;
        randomfloat = (CCRANDOM_0_1() * 3);
    }
}

//when the cat collides with the coffee ball, remove the ball
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(CCNode *)cat ball:(Ball *)coffeeball {
    coffeeball.visible=NO;
    coffeeball.physicsBody.collisionMask=@[];
    
    energy += coffeeball.coffeeEnergy;
    [self changeScorebarScale];
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

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair buffer:(CCNode *)nodeA cup:(Cup *)nodeB {
    if (nodeB.didEnterGameplay == true) {
        return YES;
    }
    else {
        return NO;
    }
}
     
-(void)ballRemoved:(CCNode *)ball {
    [ball removeFromParent];
}


//change the timer every second
-(void)updateTime {
    timeSinceStart += 1;
    
    int seconds = timeSinceStart % 60;
    int minutes = (timeSinceStart / 60) % 60;
    
    NSString *timeString = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    _timeLabel.string = timeString;
    }

-(void)changeScorebarScale {
    float energyRatio = energy/totalEnergy;
    _scorebar.scaleY = energyRatio ;
    if (energyRatio == 0) {
        CCScene *mainScene = [CCBReader loadAsScene:@"GameOver"];
        [[CCDirector sharedDirector] replaceScene:mainScene];
    }
    
}


//lose some energy every second
-(void)loseEnergyIncrementally {
    energy -= 0.5;
    [self changeScorebarScale];
}

@end





