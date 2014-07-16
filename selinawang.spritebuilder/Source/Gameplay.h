//
//  Gameplay.h
//  selinawang
//
//  Created by Selina Wang on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Gameplay : CCNode <CCPhysicsCollisionDelegate>


@property (nonatomic, strong) NSMutableArray *coffeeCupsOnScreen;


@property (nonatomic, assign) float timeSinceCup;









@end
