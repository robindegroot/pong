package actors 
{
 import utils.Controller; 
 import flash.events.Event;

 public class Player extends Paddle 
 {
  private var controller:Controller;
  private var speed:Number = 0;
  private var _maxSpeed:Number = 10;
  
  public function set maxSpeed(n:Number):void
  {
   _maxSpeed = n;
  }
  
  public function get maxSpeed():Number
  {
   return _maxSpeed;
  }
  
  public function Player() 
  {
   this.addEventListener(Event.ADDED_TO_STAGE, init);  
  }  
  private function init(e:Event):void 
  {
   this.removeEventListener(Event.ADDED_TO_STAGE, init);
   controller = new Controller(stage);
   this.addEventListener(Event.ENTER_FRAME, loop); 
   this.addEventListener(Event.REMOVED_FROM_STAGE,remove);
  }
  private function loop(e:Event):void 
  {
   if (_maxSpeed > 10)
   { 
    _maxSpeed = 10;
   }
  
   if (controller.up)
   {
    speed = -_maxSpeed;
   }
   else if(controller.down)
   {
    speed = _maxSpeed;
   }
   
   else
   {
    if (speed > 0)
    {
     speed--;
    }
    
    if (speed < 0)
    {
     speed++;
    }
   }
   
   if (this.y < 0) 
   {
    this.y = 0;
   }
   
   if (this.y > stage.stageHeight)
   {
    this.y = stage.stageHeight;
   }
   
   this.y += speed;
  }
  
  private function remove(e:Event):void
  {
   this.removeEventListener(Event.ENTER_FRAME,loop);
  }
  
 }

}
		


