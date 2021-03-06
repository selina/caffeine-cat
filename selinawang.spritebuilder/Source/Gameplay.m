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
#import "GameOver.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_coffeeCupTypeArray;
    int catEnergy;
    float randomfloat;
    int timeSinceStart;
    CCLabelTTF *_timeLabel;
    CCNode *_scorebar;
    float energy;
    float totalEnergy;
    Cat *_cat;
    CCSprite *_cloud;
    CCNode *border;
    float energyLossIncrement;
    float energyLostPerSecond;
    float maximumTimeSinceCup;
    int velocityThreshold;
    CCNode *_grass;
}


- (void)didLoadFromCCB {
    // tell the scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.contentNode = _contentNode; 
    self.currentPhysicsNode = _physicsNode; 
    _coffeeCupTypeArray = [NSMutableArray arrayWithObjects:  @"orange", @"yellow", @"red", nil];
    self.coffeeCupsOnScreen = [NSMutableArray arrayWithObjects: nil];
    _cat.gameplayLayer = self;
    timeSinceStart = 0;
    randomfloat = 0;
    _cloud.physicsBody.collisionType=@"cloud";
    
    NSURL *catNoiseUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CatNoise" ofType:@"wav"]];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)catNoiseUrl, &catNoise);
  
    [self schedule:@selector(updateTime) interval:1];
    [self schedule:@selector(loseEnergyIncrementally) interval:.1];
    [self schedule:@selector(loseEnergyFaster) interval:10];
    [self schedule:@selector(setMaxTimeSinceCup) interval:11];
    [self schedule:@selector(cupsFallFaster) interval:8];
    
   // _physicsNode.debugDraw = true;
    _physicsNode.collisionDelegate = self;
    totalEnergy = 100;
    energy = 100;
    energyLostPerSecond = 5;
    energyLossIncrement = .5;
    maximumTimeSinceCup = 3;
    velocityThreshold = 50; 
}

- (void)update:(CCTime)delta {
    [self generateNewCup:delta];
    
}

# pragma mark generate cups and move them down


-(void)generateCup{
    //generates random cup type at a random x position at the top
    
    int randomint = arc4random_uniform(3);
    Cup *cupinstance = (Cup*)[CCBReader load:[_coffeeCupTypeArray objectAtIndex:randomint]];
    //cupinstance.physicsBody.body.body->velocity_func = cupUpdateVelocity;
    cupinstance.cupfill = [_coffeeCupTypeArray objectAtIndex:randomint];
    
    
    if ([cupinstance.cupfill isEqualToString:@"yellow"]) {
        cupinstance.isEmpty = true;
    }
    else if ([cupinstance.cupfill isEqualToString:@"orange"] || [cupinstance.cupfill isEqualToString:@"red"]) {
        cupinstance.isEmpty = false;
    }
    
    srandom(time(NULL));
    
    float contentNodeWidth = _contentNode.contentSize.width;
    
    float x = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.8);
    float y = _cloud.position.y;
    CGPoint cupLocation = ccp(x, y);
    
    cupinstance.positionType = CCPositionTypeNormalized;
    cupinstance.position = cupLocation;
    
    cupinstance.gameplayLayer = self; 
    [_physicsNode addChild:cupinstance];
    
    [self.coffeeCupsOnScreen addObject:cupinstance];
    
    int randomvelocity = arc4random_uniform(40) + velocityThreshold;
    int negativevelocity = -1 * randomvelocity;

    
    cupinstance.physicsBody.velocity = ccp(0, negativevelocity);
}

-(void)cupsFallFaster {
    velocityThreshold += 10;
}
-(void)generateNewCup:(CCTime)delta {
    //after random amount of time less than three seconds: generate new cup
    
    srandom(time(NULL));
    
    _timeSinceCup += delta;
    
    if (_timeSinceCup > randomfloat) {
        [self generateCup];
        _timeSinceCup = 0;
        randomfloat = clampf((CCRANDOM_0_1() * maximumTimeSinceCup),0.5,maximumTimeSinceCup);
    }
}

-(void)setMaxTimeSinceCup {
    maximumTimeSinceCup *= 0.9;
}

#pragma mark collisions

//when the cat collides with the coffee ball, remove the ball
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(CCNode *)cat ball:(Ball *)coffeeball {
    coffeeball.visible=NO;
    coffeeball.physicsBody.collisionMask=@[];
    [_cat.animationManager runAnimationsForSequenceNamed:@"vibrate"];
    if (energy < 100) {
        energy += coffeeball.coffeeEnergy;
    [self changeScorebarScale];
        AudioServicesPlaySystemSound(catNoise); 
    }

    return NO;
}

//cat does not collide w/ cup
-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(CCNode *)nodeA cup:(CCNode *)nodeB {
    return NO;
}

//cup collides with buffer if cup in gameplay

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair buffer:(CCNode *)nodeA cup:(Cup *)nodeB {
    return YES;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cup:(CCNode *)nodeA border:(CCNode *)nodeB {
    return YES;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA border:(CCNode *)nodeB {
    return NO;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cup:(CCNode *)nodeA ground:(CCNode *)nodeB {
    CCNode *animation=[CCBReader load:@"numbersFlashing"];
    animation.positionType = CCPositionTypeNormalized;
    animation.position = ccp(.5,.5);
    [nodeA addChild:animation];
    
    nodeA.physicsBody.collisionType = @"cupCollided";
    
    //remove cup after three seconds
    [self performSelector:@selector(removeLitter:) withObject:nodeA afterDelay:3.f];
    
    return NO;
}



-(void)removeLitter:(Cup*)cupinstance{
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"CupExplosion"];
    explosion.autoRemoveOnFinish = true;
    explosion.position = cupinstance.positionInPoints;
    [cupinstance.parent addChild:explosion];
    
    [cupinstance removeFromParent];
    energy -= 3;
    [self changeScorebarScale];

}



#pragma mark scorebar, timer, pause

//change the timer label every second
-(void)updateTime {
    timeSinceStart += 1;
    [self convertSecondsToString:timeSinceStart];

    _timeLabel.string = self.timeString;
    }

-(void)convertSecondsToString:(int)secondsint {
    int seconds = secondsint % 60;
    int minutes = (secondsint/ 60) % 60;
    
    self.timeString = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
}

//call this method when you want to change the scorebar
-(void)changeScorebarScale {
    float energyRatio = energy/totalEnergy;
    _scorebar.scaleY = energyRatio ;
    if (energyRatio <= 0) {
        [self gameOver];
    }
}

//lose some energy every second
-(void)loseEnergyIncrementally {
    energy -= energyLossIncrement;
    [self changeScorebarScale];
}

-(void)loseEnergyFaster {
    energyLostPerSecond = energyLostPerSecond * 1.2;
    energyLossIncrement = energyLostPerSecond / 10;
}

- (void)pause {
    CCScene *pauseScene = [CCBReader loadAsScene:@"PauseScene"];
    [[CCDirector sharedDirector] pushScene:pauseScene];
}

-(void)gameOver {
    self.totalTime = timeSinceStart;
    GameOver *gameover = (GameOver*)[CCBReader load:@"GameOver"];
    gameover.timeString = self.timeString;
    gameover.gameplayLayer = self;
    CCScene *gameoverScene = [CCScene node];
    [gameoverScene addChild:gameover];
    [[CCDirector sharedDirector] replaceScene:gameoverScene];
}

@end





