//
//  DriverNode.m
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 5/10/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import "DriverNode.h"
#import "Util.h"

@interface DriverNode()
@property (nonatomic) CGPoint positionInGame;
@property (nonatomic) double velocity;
@property (nonatomic) CGPoint velocityVector;
@property (nonatomic) double theta;
@property (nonatomic) BOOL isAI;
@property (nonatomic) double maxVelocity;
@property (nonatomic) CGRect frameBounds;
@end

@implementation DriverNode
+(instancetype)newDriverNodeAtPosition:(CGPoint)position inMap:(CGRect)map
{
    DriverNode *driver = [self spriteNodeWithImageNamed:@"mainCharacter"];
    [driver initializeWithPosition:position inMap:map];
    driver.position = position;
    driver.zPosition = 1;
    driver.name = @"mario";
    return driver;
}
-(void)initializeWithPosition:(CGPoint)position inMap:(CGRect)map
{
    self.positionInGame = position;
    self.velocity = 0;
    self.theta = PI / 2;
    self.isAI = NO;
    self.maxVelocity = 5;
    self.velocityVector = CGPointMake(0, 0);
    self.frameBounds = map;
}
-(void)moveTick
{
    //using the velocity and position to get virtual position
    self.positionInGame = [Util addCGpoint1:self.positionInGame toCGPoint2:[self getVelocityVector]];
}
-(CGPoint)getVelocityVector
{
    return self.velocityVector;
}
-(void)setUpAsAI
{
    self.isAI = YES;
}
-(CGPoint)getNewAnchorPoint
{
    //create a value 0-1.0 for the anchor point
    return [Util divideCGpoint1:self.positionInGame toCGPoint2:CGPointMake(self.frameBounds.size.width, self.frameBounds.size.height)];
}
-(void)addVelocity:(double)velocity
{
    double possibleNewVelocity = velocity + self.velocity;
    //only change magnitude if it can be changed
    if (fabs(possibleNewVelocity) < self.maxVelocity)
    {
        self.velocity = possibleNewVelocity;
    }
    //depends on rotation
    self.velocityVector = CGPointMake(self.velocity * cos(self.theta), self.velocity * sin(self.theta));
}
-(double)getVelocity
{
    return self.velocity;
}
-(void)addRotation:(double)theta
{
    self.theta -= theta;
}
-(double)getScale
{
    return 1 - self.velocity / (5 * self.maxVelocity);
}
-(BOOL)canSpeedUp
{
    if (fabs(self.velocity) < self.maxVelocity)
    {
        return true;
    }
    else
    {
        return false;
    }
}
@end
