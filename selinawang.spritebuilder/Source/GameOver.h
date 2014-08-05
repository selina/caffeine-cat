//
//  GameOver.h
//  selinawang
//
//  Created by Selina Wang on 7/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Gameplay.h"

@interface GameOver : CCNode

@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, weak) Gameplay *gameplayLayer; 
 

-(void)setScoreLabels;


@end
