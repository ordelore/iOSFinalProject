//
//  BackgroundNode.h
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 5/11/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface BackgroundNode : SKSpriteNode
+(instancetype)newBackground:(CGRect)frame;
-(CGPoint)isCollidingAtPoint:(CGPoint)point withBounds:(CGRect)bounds andRotation:(double)rotation;
@end
