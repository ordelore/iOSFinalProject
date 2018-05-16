//
//  TitleScene.m
//  mode7FinalProject
//
//  Created by Orders, Lorenzo (502855) on 4/26/18.
//  Copyright © 2018 8x Productions. All rights reserved.
//

#import "TitleScene.h"
#import "GamePlayScene.h"
//UNCOMMENT WHEN READY FOR MUSIC
//#import <AVFoundation/AVFoundation.h>
//@interface TitleScene ()
//@property (nonatomic) SKAction *pressStartSFX;
//@property (nonatomic) AVAudioPlayer *backgroundMusic;
//@end

@implementation TitleScene
-(instancetype)initWithSize:(CGSize)size
{
    if(self == [super initWithSize:size])
    {
        //        //if it works, return YES
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"mario-kart"];
        //always centers the background regardless of phone
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        //make the image fit into the screen
        background.size = self.frame.size;
        [self addChild:background];
        //UNCOMMENT WHEN READY FOR MUSIC
//        //prepare the sound action for use
//        self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
//        
//        //black magic that even Carlson doesn't know
//        //this is like linking to the url file
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"nevergonnagiveyouup" withExtension:@"mp3"];
//        
//        //setup music player
//        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        //play music forever
//        self.backgroundMusic.numberOfLoops = -1;
        
    }
    return self;
}
//UNCOMMENT WHEN READY TO ADD MUSIC
//-(void)didMoveToView:(SKView *)view
//{
//    //whenever the view displays
//    [self.backgroundMusic play];
//}
//handles when the screen is touched
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //create an instance of the game screen
    GamePlayScene *gamePlay = [GamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    //UNCOMMENT WHEN READY FOR SOUND
//    //play the sound action
//    [self runAction:self.pressStartSFX];
//    [self.backgroundMusic stop];
    //present a new scene with a certian transition
    [self.view presentScene:gamePlay transition:transition];
    
}
@end
