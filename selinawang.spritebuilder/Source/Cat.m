//
//  Cat.m
//  selinawang
//
//  Created by Selina Wang on 7/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Cat.h"

@implementation Cat {
    float speed;
    float x;
    float y;
}

-(void)didLoadFromCCB {
    self.physicsBody.collisionType = @"cat";
    
        
}



@end
