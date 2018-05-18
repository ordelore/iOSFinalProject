//
//  Util.m
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 4/30/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import "Util.h"

@implementation Util
+(double)toRadians:(double)degrees
{
    return PI / 180.0 * degrees;
}
+(CGPoint)addCGpoint1:(CGPoint)p1 toCGPoint2:(CGPoint)p2
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}
+(CGPoint)multiplyCGpoint1:(CGPoint)p1 toCGPoint2:(CGPoint)p2
{
    return CGPointMake(p1.x * p2.x, p1.y * p2.y);
}
+(CGPoint)divideCGpoint1:(CGPoint)p1 toCGPoint2:(CGPoint)p2
{
    return CGPointMake(p1.x / p2.x, p1.y / p2.y);
}
+(CGPoint)pointMultiplied:(CGPoint)p1 byScalar:(double)x
{
    return CGPointMake(p1.x * x, p1.y * x);
}
+(double)vectorMagnitudeOfVector:(CGPoint)p1
{
    return sqrt(p1.x * p1.x + p1.y * p1.y);
}
+(BOOL)point:(CGPoint)p1 equals:(CGPoint)p2
{
    return p1.x == p2.x && p1.y == p2.y;
}
+(void)IFPrint:(NSString *) format, ...
{
    va_list args;
    va_start(args, format);
    
    fputs([[[NSString alloc] initWithFormat:format arguments:args] UTF8String], stdout);
    
    va_end(args);
}
@end
