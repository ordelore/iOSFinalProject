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
-(CGPoint)isCollidingAtPoint:(CGPoint)point withBounds:(CGRect)bounds andRotation:(double)rotation
{
    //assuming that the thing's anchor point is in the center
    //test the corners, and the midpoints
    double innerTheta = rotation;
    double outerTheta = PI / 4 + rotation;
    double innerRadius = bounds.size.width / 2;
    double outerRadius = 0.5 * sqrt(pow(bounds.size.width, 2) + pow(bounds.size.height, 2));
    CGPoint outerPoint;
    CGPoint innerPoint;
    int tileWidth = 8;
    for (double i = 0; i < 2 * PI; i += PI / 2)
    {
        outerPoint = CGPointMake(point.x + outerRadius * cos(i + outerTheta), point.y + outerRadius * sin(i + outerTheta));
        innerPoint = CGPointMake(point.x + innerRadius * cos(i + innerTheta), point.y + innerRadius * sin(i + innerTheta));
        if (!(outerPoint.y > tileWidth * 126 || outerPoint.x > tileWidth * 128 || innerPoint.y > tileWidth * 126 || innerPoint.x > tileWidth * 128))
        {
            if (1 == tilemap[(int)(outerPoint.y / tileWidth)][(int)outerPoint.x / tileWidth])
            {
                return CGPointMake(-cos(i+outerTheta), -sin(i+outerTheta));
            }
            if (1 == tilemap[(int)(innerPoint.y / tileWidth)][(int)(innerPoint.x / tileWidth)])
            {
                return CGPointMake(-cos(i+innerTheta), -sin(i+innerTheta));
            }
        }
    }
    //only return 0 if none of the points collide
    return CGPointMake(0, 0);
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
    
    //Used for determining if the
    NSString *line = @"";
    for (int i = 0; i < 126; i++)
    {
        for (int j = 0; j < 128; j++)
        {
            line = [line stringByAppendingString:[NSString stringWithFormat:@"%i", tilemap[i][j]]];
        }
        [Util IFPrint:[line stringByAppendingString:@"\n"]];
        line = @"";
    }
}

@end
