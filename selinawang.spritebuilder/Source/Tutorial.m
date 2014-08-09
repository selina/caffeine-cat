//
//  Tutorial.m
//  selinawang
//
//  Created by Selina Wang on 8/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tutorial.h"
#import "Gameplay.h"

@implementation Tutorial {
    CCLabelTTF *catgettingtired;
    CCLabelTTF *taptoremove;
    CCLabelTTF *taptorelease;
    CCLabelTTF *feedballtocat;
    CCLabelTTF *fullcupstwice;
    CCLabelTTF *nobuildup;
    CCLabelTTF *howlongawake;

}

-(void)onEnter {
    [super onEnter];
    NSMutableArray *instructionArray = [NSMutableArray arrayWithObjects:catgettingtired, taptoremove, taptorelease, feedballtocat, fullcupstwice, nobuildup, howlongawake, nil];
    for (CCLabelTTF *instructions in instructionArray) {
        instructions.visible = NO;
    }
    }

-(void)next {
    
}

-(void)play {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}



@end
