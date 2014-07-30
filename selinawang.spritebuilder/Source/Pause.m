//
//  Pause.m
//  selinawang
//
//  Created by Selina Wang on 7/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Pause.h"

@implementation Pause


-(void)quit {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

-(void)restart {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

// TODO: add settings

-(void)settings {
    CCScene *mainScene = [CCBReader loadAsScene:@"Settings"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
