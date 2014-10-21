#import "GamePlayScene.h"
#import "Character.h"
#import "Obstacle.h"

@implementation GamePlayScene

- (void)initialize
{
    // your code here
    character = (Character*)[CCBReader load:@"Character"];
    [physicsNode addChild:character];
    [self addObstacle];
    timeSinceObstacle = 0.0f;
}

-(void)update:(CCTime)delta
{
    // put update code here
    // this will be run every frame.
    // delta is the time that has elapsed since the last time it was run. This is usually 1/60, but can be bigger if the game slows down
    // Increment the time since the last obstacle was added
    timeSinceObstacle += delta; // delta is approximately 1/60th of a second
    
    // Check to see if two seconds have passed
    if(timeSinceObstacle > 2.0f)
    {
        // Add a new obstacle
        [self addObstacle];
        
        // Then reset the timer.
        timeSinceObstacle = 0.0f;
    }
    
    for(CCNode *bush in _bushes){
        // move the bush
        bush.position = ccp(bush.position.x - (character.physicsBody.velocity.x * delta), bush.position.y);
        
        // if the left corner is one complete width off the screen,
        // move it to the right
        if (bush.position.x <= (-1 * bush.contentSize.width)) {
            bush.position = ccp(bush.position.x +
                                2 * bush.contentSize.width, bush.position.y);
        }
    }
}

// put new methods here
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    // this will get called every time the player touches the screen
    [character flap];
}

@end
