//
//  HelloWorldLayer.h
//  spinner_test
//
//  Created by Kevin Loken on 11-09-02.
//  Copyright Stone Sanctuary Interactive Inc. 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCTMXTiledMap* _tileMap;
    CCTMXLayer* _background;
    CCSprite* _player;
}

@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic, retain) CCSprite *player;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)rotateLeft;
-(void)rotateRight;

-(void)setViewpointCenter:(CGPoint) position;

@end
