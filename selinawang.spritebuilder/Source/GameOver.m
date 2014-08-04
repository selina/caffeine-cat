//
//  GameOver.m
//  selinawang
//
//  Created by Selina Wang on 7/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver {
    CCLabelTTF *_lastScore;
    CCLabelTTF *_bestScore; 
}

-(void)onEnter{
    [super onEnter];
    [self setScoreLabels];
}
-(void)playAgain {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

-(void)quit {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

-(void)settings {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Settings"];
    [[CCDirector sharedDirector] pushScene:gameplayScene];
}

-(void)setScoreLabels {
    _lastScore.string = self.timeString;
    //translate string into seconds
    //if last score greater than best score, best score equals last score
    
}

@end
