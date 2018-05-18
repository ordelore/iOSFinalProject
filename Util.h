//
//  Util.h
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 4/30/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
static const double PI = 3.14159265358979323846264338327;

@interface Util : NSObject
+(double)toRadians: (double)degrees;
+(CGPoint)addCGpoint1:(CGPoint)p1 toCGPoint2:(CGPoint)p2;
+(CGPoint)multiplyCGpoint1:(CGPoint)p1 toCGPoint2:(CGPoint)p2;
+(CGPoint)divideCGpoint1:(CGPoint)p1 toCGPoint2:(CGPoint)p2;
+(double)vectorMagnitudeOfVector:(CGPoint)p1;
+(BOOL)point:(CGPoint)p1 equals:(CGPoint)p2;
+(CGPoint)pointMultiplied:(CGPoint)p1 byScalar:(double)x;
+(void)IFPrint:(NSString *) format, ...;
@end
