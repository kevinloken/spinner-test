//
//  HelloWorldLayer.m
//  spinner_test
//
//  Created by Kevin Loken on 11-09-02.
//  Copyright Stone Sanctuary Interactive Inc. 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

@interface Hud : CCLayer {
@private
    HelloWorldLayer* _delegate;
}

@property (nonatomic, retain) HelloWorldLayer *delegate;
@end

@implementation Hud

@synthesize delegate = _delegate;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
     
	}
	return self;
}

-(void)setDelegate:(HelloWorldLayer *)delegate
{
    [delegate retain];
    [_delegate release];
    _delegate = delegate;
    
    CCMenuItemFont* left = [CCMenuItemFont itemFromString:@"left" target:_delegate selector:@selector(rotateLeft)];
    CCMenuItemFont* right = [CCMenuItemFont itemFromString:@"right" target:_delegate selector:@selector(rotateRight)];
    CCMenu* menu = [CCMenu menuWithItems:left, right, nil];
    [menu alignItemsHorizontally];
    menu.position = ccp(240,26);
    
    [self addChild: menu z:128];       
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize player = _player;
@synthesize background = _background;
@synthesize tileMap = _tileMap;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	// add layer as a child to scene
	[scene addChild: layer z:-1];
    
    Hud *hud = [Hud node];
    [hud setDelegate:layer];
	
    [scene addChild:hud];
    
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {

        
        self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"desert.tmx"];
        
        self.background  = [_tileMap layerNamed:@"Background"];
        
        self.player = [CCSprite spriteWithFile:@"Player.png"];
        
        [self addChild:_tileMap z:-1];
        [self addChild:_player  z:1];
        
        CGPoint center = CGPointMake(_tileMap.mapSize.width * _tileMap.tileSize.width / 2, _tileMap.mapSize.height * _tileMap.tileSize.height/2);

        CGPoint half = ccp(0.5,0.5);
        _tileMap.anchorPoint = half;
        
        [self setViewpointCenter:center];
        [self setPlayerPosition:ccp(0,0)];

	}
	return self;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	self.tileMap = nil;
    self.background = nil;
    self.player = nil;
    
	// don't forget to call "super dealloc"
	[super dealloc];
}


-(void)setPlayerPosition:(CGPoint)position {
	_player.position = position;
}

-(void)setViewpointCenter:(CGPoint) position {
    // on orientation change, just rotate the _player sprite
    // the x,y are going to be determined by the orientation
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width) 
            - winSize.width / 2);
    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height) 
            - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    
    self.position = viewPoint;    
}


-(void)rotateLeft
{
    CCLOG(@"rotate left");

    // _tileMap.anchorPoint = _player.position;
    float width = _tileMap.mapSize.width * _tileMap.tileSize.width;
    float height = _tileMap.mapSize.height * _tileMap.tileSize.height;
    CGPoint anchor = _tileMap.anchorPoint;
    CGPoint pos    = _tileMap.position;
    
    CGPoint d_anchor = CGPointMake(_player.position.x / width, _player.position.y / height);
    CGPoint delta = ccpSub(anchor, d_anchor);
    delta.x = delta.x * _tileMap.tileSize.width;
    delta.y = delta.y * _tileMap.tileSize.height;
    
    CGPoint view = ccpAdd(pos, delta);
    
    _tileMap.anchorPoint = d_anchor;
    [_tileMap runAction:[CCRotateBy actionWithDuration:0.25f angle:-90]];  
    
    _player.position = _tileMap.anchorPoint;
    
    [self setViewpointCenter:view];
}

-(void)rotateRight
{
    CCLOG(@"rotate right");
    // _tileMap.anchorPoint = _player.position;
    [self runAction:[CCRotateBy actionWithDuration:0.25f angle:90]];
    [self setViewpointCenter:_player.position];

}

@end
