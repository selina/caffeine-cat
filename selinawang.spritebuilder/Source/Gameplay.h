//
//  Gameplay.h
//  selinawang
//
//  Created by Selina Wang on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Gameplay : CCNode <CCPhysicsCollisionDelegate> {
    SystemSoundID catNoise; 
}


@property (nonatomic, strong) NSMutableArray *coffeeCupsOnScreen;
@property (nonatomic, strong) CCPhysicsNode *currentPhysicsNode; 
@property (nonatomic, strong) CCNode *contentNode;
@property (nonatomic, assign) float timeSinceCup;
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, assign) int totalTime; 


@end
