//
//  GamePlayScene.m
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 4/26/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import "GamePlayScene.h"
#import "Util.h"
#import "DriverNode.h"
#import "BackgroundNode.h"

@interface GamePlayScene()
@property (nonatomic) double i;
@property (nonatomic) BOOL isTurningLeft;
@property (nonatomic) BOOL isTurningRight;
@property (nonatomic) BOOL gameStarted;
@property (nonatomic) int leftAndRightButtonSizeWidth;
@property (nonatomic) int leftAndRightButtonSizeHeight;
@property (nonatomic) int countdownClock;
@property (nonatomic) NSTimeInterval timeSinceLastFrame;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) BackgroundNode *map;
@property (nonatomic) double idealFPS;
@property (nonatomic) double j;
@property (nonatomic) double theta;
@property (nonatomic) double k;
@property (nonatomic) DriverNode *mainCharacter;
@end

@implementation GamePlayScene
-(instancetype)initWithSize:(CGSize)size
{
    if(self == [super initWithSize:size])
    {
        //https://stackoverflow.com/questions/32742403/spritekit-missing-linear-transformation-matrices?noredirect=1&lq=1 < For using linear transformations
        SKSpriteNode *plainBackground = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:self.frame.size];

        //always centers the background regardless of phone
        plainBackground.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        //make the image fit into the screen
        plainBackground.size = self.frame.size;
        plainBackground.zPosition = -1;
        [self addChild:plainBackground];
        
        self.map = [BackgroundNode newBackground:self.frame];
        [self addChild:self.map];
        
        self.mainCharacter = [DriverNode newDriverNodeAtPosition:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) inMap:self.map.frame];
        [self addChild:self.mainCharacter];
        
        SKLabelNode *countdown = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
        countdown.fontSize = 50;
        countdown.text = @"5";
        countdown.name = @"Countdown";
        countdown.fontColor = [UIColor redColor];
        countdown.zPosition = self.map.zPosition + 1;
        countdown.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height - countdown.frame.size.height);
        countdown.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:countdown];
        
        //set up global variables
        self.timeSinceLastFrame = 0;
        self.isTurningLeft = NO;
        self.isTurningRight = NO;
        self.leftAndRightButtonSizeWidth = self.frame.size.width / 8;
        self.leftAndRightButtonSizeHeight = self.frame.size.height;
        self.idealFPS = 1;
        self.gameStarted = NO;
        self.countdownClock = 5;
        self.lastUpdateTimeInterval = 0;
        self.timeSinceLastFrame = 0;
        
        //testing variables
        self.i = 0.0;
        self.j = 0.0;
        self.theta = 0.1;
        self.k = 0;
    }
    return self;
}
-(void)update:(NSTimeInterval)currentTime
{
    if(self.lastUpdateTimeInterval)
    {
        self.timeSinceLastFrame += currentTime - self.lastUpdateTimeInterval;
    }
    self.lastUpdateTimeInterval = currentTime;
    
    if(!self.gameStarted && self.timeSinceLastFrame > self.idealFPS)
    {
        SKLabelNode *countdown = (SKLabelNode *)[self childNodeWithName:@"Countdown"];
        self.countdownClock -= 1;
        countdown.text = [NSString stringWithFormat:@"%i", self.countdownClock];
        if (self.countdownClock <= 0)
        {
            self.gameStarted = YES;
            countdown.position = CGPointMake(self.frame.size.width, self.frame.size.height);
            self.idealFPS = 0.1;
        }
        self.timeSinceLastFrame = 0;
    }
    //only run this code every fps tick
    if (self.gameStarted && self.timeSinceLastFrame > self.idealFPS)
    {
        //self.theta += 0.1;
        if(self.isTurningRight)
        {
            self.map.zRotation += 0.05;
            [self.mainCharacter addRotation:0.05];
            [self.mainCharacter addVelocity:-5.0E-2];
        }
        if(self.isTurningLeft)
        {
            self.map.zRotation -= 0.05;
            [self.mainCharacter addRotation: -0.05];
            [self.mainCharacter addVelocity:-5.0E-2];
        }
        if(!(self.isTurningLeft || self.isTurningRight) && [self.mainCharacter canSpeedUp])
        {
            //speed up only if not turning
            [self.mainCharacter addVelocity:1.0E-1];
        }
        
        if(self.isTurningRight || self.isTurningLeft || [self.mainCharacter canSpeedUp])
        {
            [self rescaleMap];
        }
        [self.mainCharacter moveTick];
        self.map.anchorPoint = [self.mainCharacter getNewAnchorPoint];
    }
}

-(void)rescaleMap
{
    double scale = [self.mainCharacter getScale];
    
    self.map.xScale = scale;
    self.map.yScale = scale;
    self.mainCharacter.xScale = scale;
    self.mainCharacter.yScale = scale;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for(UITouch *touch in touches)
    {
        if ([touch locationInView:touch.view].x < self.leftAndRightButtonSizeWidth && !self.isTurningLeft)
        {
            //turning left
            self.isTurningLeft = YES;
        }
        
        if ([touch locationInView:touch.view].x > self.frame.size.width - self.leftAndRightButtonSizeWidth && !self.isTurningRight)
        {
            //turning right
            self.isTurningRight = YES;
        }
        //TODO item spawn, drifting, acceleration, braking
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //FOR STOPPING THE TURN
    for(UITouch *touch in touches)
    {
        if ([touch locationInView:touch.view].x < self.leftAndRightButtonSizeWidth && self.isTurningLeft)
        {
            //turning left
            self.isTurningLeft = NO;
        }
        
        if ([touch locationInView:touch.view].x > self.frame.size.width - self.leftAndRightButtonSizeWidth && self.isTurningRight)
        {
            //turning right
            self.isTurningRight = NO;
        }
        //TODO item spawn, drifting, acceleration, braking
    }
}

@end
