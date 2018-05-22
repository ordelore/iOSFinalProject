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
@property (nonatomic) double frameBoundsX;
@property (nonatomic) double frameBoundsY;
@end

@implementation DriverNode
+(instancetype)newDriverNodeAtPosition:(CGPoint)position inMap:(CGRect)map inFrame:(CGRect)frame
{
    DriverNode *driver = [self spriteNodeWithImageNamed:@"mainCharacter"];
    //anchor point = position / map
    //position = anchor point * map
    [driver initializeWithPosition:[Util multiplyCGpoint1:position toCGPoint2:CGPointMake(map.size.width, map.size.height)] inMap:map];
    driver.position = CGPointMake(frame.size.width / 2, frame.size.height / 2);
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
    self.frameBoundsX = map.size.width;
    self.frameBoundsY = map.size.height;
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
    return [Util divideCGpoint1:self.positionInGame toCGPoint2:CGPointMake(self.frameBoundsX, self.frameBoundsY)];
}
-(void)addVelocity:(double)velocity
{
    self.velocity = velocity + self.velocity;
    //depends on rotation
    self.velocityVector = CGPointMake(self.velocity * cos(self.theta), self.velocity * sin(self.theta));
    //self.theta = atan(self.velocityVector.y / self.velocityVector.x);
    [Util IFPrint:[NSString stringWithFormat:@"%f : %f\n", self.theta, atan(self.velocityVector.y / self.velocityVector.x)]];
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
-(CGPoint)getIngamePosition
{
    return self.positionInGame;
}
-(void)collidedWithVector:(CGPoint)point
{
    self.velocityVector = [Util addCGpoint1:self.velocityVector toCGPoint2:[Util pointMultiplied:point byScalar:self.velocity]];
    self.theta = atan(self.velocityVector.y / self.velocityVector.x);
    //self.theta = atan(point.y / point.x);
    self.velocity = [Util vectorMagnitudeOfVector:self.velocityVector];
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
-(double)getRotation
{
    return self.theta;
}
@end
