//
//  BackgroundNode.h
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 5/8/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BackgroundNode : SKNode
+(instancetype)backgroundWithSprite: (SKSpriteNode *)background;
-(void)initialize;
@property (nonatomic) double angle;
@property (nonatomic) double cameraX;
@property (nonatomic) double cameraY;
@property (nonatomic) double height;
@property (nonatomic) double width;
@property (nonatomic) double horizon;
@property (nonatomic) SKSpriteNode *map;

@end
