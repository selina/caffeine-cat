//
//  Cup.h
//  selinawang
//
//  Created by Selina Wang on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Gameplay.h"

@interface Cup : CCNode

@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, assign) float x_position;
@property (nonatomic, assign) float y_position;
@property (nonatomic, weak) Gameplay *gameplayLayer;
@property (nonatomic, strong) NSString *cupfill;
@property (nonatomic, assign) BOOL didEnterGameplay;


-(void)cupTapped;
-(void)removeCup;
-(void)checkIfCupInGameplay;
@end
