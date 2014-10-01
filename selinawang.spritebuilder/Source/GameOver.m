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
    NSString *highScoreString;
    CCLabelTTF *newHighScore;
}

-(void)onEnter{
    [super onEnter];
    [self setScoreLabels];
    newHighScore.visible = NO;
    
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
    int lastScoreInt = self.gameplayLayer.totalTime;
    //if last score greater than best score, best score equals last score
    int highScoreInt = [[NSUserDefaults standardUserDefaults] integerForKey:@"High Score Int"];
    if (lastScoreInt > highScoreInt) {
        highScoreInt = lastScoreInt;
        [[NSUserDefaults standardUserDefaults] setInteger:highScoreInt forKey:@"High Score Int"];
        
        [self convertSecondsToString:highScoreInt];
        highScoreString = self.timeString;
        _bestScore.string = highScoreString;
        
        [[NSUserDefaults standardUserDefaults] setObject:highScoreString forKey:@"High Score String"];
        
        newHighScore.visible = YES;
        
    }
    else {
        highScoreString = [[NSUserDefaults standardUserDefaults] objectForKey:@"High Score String"];
        _bestScore.string = highScoreString; 
    }
}

-(void)convertSecondsToString:(int)secondsint {
    int seconds = secondsint % 60;
    int minutes = (secondsint/ 60) % 60;
    
    self.timeString = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    
}


@end
