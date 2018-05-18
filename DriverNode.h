//
//  DriverNode.h
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 5/10/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DriverNode : SKSpriteNode
+(instancetype)newDriverNodeAtPosition:(CGPoint)position inMap:(CGRect)map;
-(CGPoint)getNewAnchorPoint;
-(void)addRotation:(double)theta;
-(void)addVelocity:(double)velocity;
-(double)getVelocity;
-(void)setUpAsAI;
-(void)moveTick;
-(CGPoint)getVelocityVector;
-(double)getScale;
-(BOOL)canSpeedUp;
-(CGPoint)getIngamePosition;
-(void)collidedWithVector:(CGPoint)point;
@end
