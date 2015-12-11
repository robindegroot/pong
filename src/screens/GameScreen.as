package screens 
{
 import actors.AI;
 import actors.Ball;
 import actors.Paddle;
 import actors.Player;
 import flash.display.Bitmap;
 import flash.display.DisplayObject;
 import flash.display.MovieClip;
 import flash.events.*;
 import flash.utils.Timer;
 import flash.geom.Point;
 import utils.MovementCalculator;
 import screens.Scoreboard;
 import actors.PowerUp;

 public class GameScreen extends Screen
 {
  private var balls:Array = [];
  private var t:Timer = new Timer(3000, 3);
  private var powerUps: Array = [];
  private var paddles:Array = [];
  private var scoreboard:Scoreboard;
  static public const GAME_OVER:String = "game over";
  static public const BALL_BOUNCE:String = "ballBounce";
  
  public function GameScreen() 
  {
   this.addEventListener(Event.ADDED_TO_STAGE, init);
   t.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
   t.start();
  }
  
  private function init(e:Event):void 
  {
   removeEventListener(Event.ADDED_TO_STAGE, init);
    
	for (var i:int = 0; i < 1; i++) 
   {
    balls.push(new Ball());
    addChild(balls[i]);
    balls[i].reset();
    balls[i].addEventListener(Ball.OUTSIDE_RIGHT, onRightOut);
    balls[i].addEventListener(Ball.OUTSIDE_LEFT, onLeftOut);
   } 
   
   paddles.push(new AI());
   paddles.push(new Player());

   paddles[1].maxSpeed += 25 ;
   
   paddles[0].balls = balls;
   
   for (i = 0; i < 2; i++) 
   {
    
    addChild(paddles[i]);
    paddles[i].y = stage.stageHeight / 2;
   } 
   
   paddles[0].x = stage.stageWidth - 100;
   
   paddles[1].x = 100;
   
   scoreboard = new Scoreboard();
   addChild(scoreboard);
   this.addEventListener(Event.ENTER_FRAME, loop);
  }  
  
  private function loop(e:Event):void 
  {
   if(powerUps.length > 0)
   {
    if(powerUps[0].hitTestObject(balls[0]))
    {
     balls[0].speed = 20;
     balls[0].speedAngle();
     if(contains(powerUps[0]))removeChild(powerUps[0]);
     powerUps.splice(0,1);
    }
   }
   checkCollision();
  } 
  
  private function checkCollision():void 
  {
   for (var i:int = 0; i < balls.length; i++) 
   {
    for (var j:int = 0; j < paddles.length; j++) 
    {
     if (paddles[j].hitTestObject(balls[i]))
     {
      balls[i].xMove *= -1;
      
      var dir:Number = balls[i].xMove / Math.abs(balls[i].xMove);
      while (paddles[j].hitTestObject(balls[i]))
      {
       balls[i].x += dir;
      }
      balls[i].x += balls[i].xMove / 2;
      dispatchEvent(new Event(BALL_BOUNCE));
     }
    }
   }
   
  }
  
  private function onLeftOut(e:Event):void 
  {
   var b:Ball = e.target as Ball;
   b.reset();
   
   scoreboard.player2 += 1;
   
   checkScore();
  }  
  private function onRightOut(e:Event):void 
  {
   var b:Ball = e.target as Ball;
   b.reset();
   scoreboard.player1 += 1;
   
   
   checkScore();
  }  
  
  private function checkScore():void 
  {
   if (scoreboard.player2 >= 10)
   {
    destroy();
    dispatchEvent(new Event(GAME_OVER));
    
   }
   
   if (scoreboard.player1 >= 10)
   {
    destroy();
	   dispatchEvent(new Event(GAME_OVER));
   }
  }
   
  private function destroy():void
  {
   for (var i:int = 0; i < balls.length; i++) 
   {
    balls[i].destroy();
    removeChild(balls[i]);
   }
   balls.splice(0, balls.length);
  }
  
  function onTimer(te:TimerEvent):void
  {
   powerUps.push(new PowerUp());
   addChild(powerUps[0]);
  }
 }

}