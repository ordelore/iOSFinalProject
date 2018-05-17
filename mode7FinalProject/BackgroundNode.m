//
//  BackgroundNode.m
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 5/11/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import "BackgroundNode.h"
#import "Util.h"

@interface BackgroundNode()
{
    NSInteger tilemap[126][128];
}
@end
@implementation BackgroundNode
+(instancetype)newBackground:(CGRect)frame
{
    BackgroundNode *background = [self spriteNodeWithImageNamed:@"marioKartMapPNG"];
    background.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    background.anchorPoint = CGPointMake(0.89, 0.38);
    background.name = @"Background";
    [background initTileMap];
    return background;
}
-(BOOL)isCollidingAtPoint:(CGPoint)point withBounds:(CGRect)bounds andRotation:(double)rotation
{
    //assuming that the thing's anchor point is in the center
    //test the corners, and the midpoints
    double innerTheta = rotation;
    double outerTheta = PI / 4 + rotation;
    double innerRadius = bounds.size.width / 2;
    double outerRadius = sqrt(pow(bounds.size.width, 2) * 0.25 + pow(bounds.size.height, 2) * 0.25);
    CGPoint outerPoint;
    CGPoint innerPoint;
    for (int i = 0; i < 2 * PI; i += PI / 2)
    {
        outerPoint = CGPointMake(outerRadius * cos(i + outerTheta), outerRadius * sin(i + outerTheta));
        innerPoint = CGPointMake(innerRadius * cos(i + innerTheta), innerRadius * sin(i + innerTheta));
        
    }
    //only return YES if none of the points collide
    return YES;
}
-(void)initTileMap
{
    //self.tilemap = int[126][128];
    // 1 = wall
    //create a simple border wall to test collision
    for (int i = 0; i < 126; i++)
    {
        tilemap[i][0] = 1;
        tilemap[i][127] = 1;
    }
    for (int i = 0; i < 128; i++)
    {
        tilemap[0][i] = 1;
        tilemap[125][i] = 1;
    }
}
@end
