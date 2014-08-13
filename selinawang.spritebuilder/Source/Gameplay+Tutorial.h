//
//  Tutorial.h
//  selinawang
//
//  Created by Selina Wang on 8/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@interface Gameplay (Tutorial)

typedef enum {
    introduction,
    empty,
    half,
    full,
    preventbuildup,
    howlong
}TutorialSteps;

@end
