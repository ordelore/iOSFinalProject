//
//  BackgroundNode.m
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 5/11/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import "BackgroundNode.h"

@implementation BackgroundNode
+(instancetype)newBackground:(CGRect)frame
{
    BackgroundNode *background = [self spriteNodeWithImageNamed:@"marioKartMapPNG"];
    background.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    background.anchorPoint = CGPointMake(0.89, 0.38);
    background.name = @"Background";
    return background;
}
-(void)initTileMap
{
    
}
@end
