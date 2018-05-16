//
//  BackgroundNode.m
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 5/8/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import "BackgroundNode.h"

@implementation BackgroundNode
+(instancetype)backgroundWithSprite:(SKSpriteNode *)background
{
    BackgroundNode *map;
    return map;
    
}
-(void)initializeOnScreen:(CGRect) frame image:(SKSpriteNode*) map
{
    _angle = 0.0;
    _cameraX = 0.0;
    _cameraY = 0.0;
    _height = frame.size.height;
    _width = frame.size.width;
    _map = map;
    _map.anchorPoint = CGPointMake(0, 0);
}
-(void)redraw
{
    //https://github.com/catmanjan/mode-7-gdx/blob/master/mode-7-gdx/src/au/com/twosquared/mode7/Mode7.java
    int width = _width;
    int height = _height;
    double sin = sinf(_angle);
    double cos = cosf(_angle);
    double horizon = _height / 2.0;
    double cameraZ = 5.0;
    //this node will crop only one pixel
    SKCropNode *cropNode = [SKCropNode node];
    SKSpriteNode *mask = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(1, 1)];
    mask.anchorPoint = CGPointMake(0, 0);
    [cropNode addChild:_map];
    [cropNode setMaskNode:mask];
}
-(void)redrawBackgroundWithScaledWidth:(double)w skewedWidth:(double)sw skewedHeight:(double)sh scaledHeight:(double)h originX:(double)xt originY:(double)yt
{
    SKEffectNode *transformationNode = (SKEffectNode *)[self childNodeWithName:@"transformationNode"];
    //CGAffineTransformMake(scale.width, skew.width, skew.height, scale.height, transform x, transform y
    CGAffineTransform rotateAndScale = CGAffineTransformMake(w, sw, sh, h, xt, yt);
    CIFilter *transformation = [CIFilter filterWithName:@"CIAffineTransform"];
    NSValue *value = [NSValue valueWithCGAffineTransform:rotateAndScale];
    [transformation setValue:value forKey:@"inputTransform"];
    transformationNode.filter = transformation;
}
@end
