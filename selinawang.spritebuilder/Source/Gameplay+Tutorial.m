//
//  Tutorial.m
//  selinawang
//
//  Created by Selina Wang on 8/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay+Tutorial.h"
#import "Cup.h"
#define CP_ALLOW_PRIVATE_ACCESS 1
#import "CCPhysics+ObjectiveChipmunk.h"



@implementation Gameplay (Tutorial)

//-(void)generateCup:(NSString*)cupfill {
//    NSLog(@"GEN");
//    
//    Cup *cupinstance = (Cup*)[CCBReader load:cupfill];
//    //cupinstance.physicsBody.body.body->velocity_func = cupUpdateVelocity2;
//    
//    
//    if ([cupinstance.cupfill isEqualToString:@"yellow"]) {
//        cupinstance.isEmpty = true;
//    }
//    else if ([cupinstance.cupfill isEqualToString:@"orange"] || [cupinstance.cupfill isEqualToString:@"red"]) {
//        cupinstance.isEmpty = false;
//    }
//    
//    srandom(time(NULL));
//    
//    float contentNodeWidth = _contentNode.contentSize.width;
//    
//    float x = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.9);
//    float y = _cloud.position.y;
//    CGPoint cupLocation = ccp(x, y);
//    
//    cupinstance.positionType = CCPositionTypeNormalized;
//    cupinstance.position = cupLocation;
//    
//    cupinstance.gameplayLayer = self;
//    [_physicsNode addChild:cupinstance];
//    cupinstance.physicsBody.collisionMask = @[];
//    //[_contentNode addChild:cupinstance];
//    
//    [self.coffeeCupsOnScreen addObject:cupinstance];
//    
//    [self performSelector:@selector(changeCollisionMask:) withObject:(cupinstance) afterDelay:(.1)];
//
//}

@end

//static void
//cupUpdateVelocity2(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt)
//{
//    cpAssertSoft(body->m > 0.0f && body->i > 0.0f, "Body's mass and moment must be positive to simulate. (Mass: %f Moment: %f)", body->m, body->i);
//    
//    body->v = cpvadd(cpvmult(body->v, damping), cpvmult(cpvmult(body->f, body->m_inv), dt));
//	body->w = body->w*damping + body->t*body->i_inv*dt;
//    
//	// Reset forces.
//	body->f = cpvzero;
//	body->t = 0.0f;
//    
//    //change this number for speed the blocks fall at
//    int randomint = arc4random_uniform(40) + 80;
//	body->v.y = -1 * randomint;
//}


@implementation Tutorial {
    CCLabelTTF *catgettingtired;
    CCLabelTTF *taptoremove;
    CCLabelTTF *taptorelease;
    CCLabelTTF *feedballtocat;
    CCLabelTTF *fullcupstwice;
    CCLabelTTF *nobuildup;
    CCLabelTTF *howlongawake;
    Gameplay *_gameplay;
}

//-(void)onEnter {
//    [super onEnter];
//    NSMutableArray *instructionArray = [NSMutableArray arrayWithObjects:catgettingtired, taptoremove, taptorelease, feedballtocat, fullcupstwice, nobuildup, howlongawake, nil];
//    for (CCLabelTTF *instructions in instructionArray) {
//        instructions.visible = NO;
//    }
//}
//
//switch(TutorialSteps) {
//    case introduction:
//        catgettingtired.visible = true;
//        
//    case empty:
//        [self generateCup:@"yellow"];
//        
//        double delayInSeconds = 1.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            taptoremove.visible = true;
//        });
//        
//    case half:
//        [self generateCup:@"orange"];
//        taptorelease.visible = true;
//        
//        
//    case full:
//        [self generateCup:@"red"];
//}
//
//-(void)generateEmptyCup {
//    
//}
//
//-(void)next {
//    
//}
//
//-(void)play {
//    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
//    [[CCDirector sharedDirector] replaceScene:mainScene];
//}

@end
