class TowerStand extends MovieClip
{
	private var positionsMax:Number;
	private var myNumber:MovieClip;
	private var myMarker:TowerBallMarker;
	private var myBalls:Array;
	
	public function showNumber():Void
	{
		myNumber._visible = true;
	}
	
	public function hideNumber():Void
	{
		myNumber._visible = false;
	}
	
	public function showMarker():Void
	{
		myMarker._visible = true;
	}
	
	public function hideMarker():Void
	{
		myMarker._visible = false;
	}
	
	public function getMarker():TowerBallMarker
	{
		return myMarker;
	}
	
	public function getBallColours():Array
	{
		var ballColours:Array = new Array();
		for (var i:Number = 0 ; i < myBalls.length; i++)
		{			
			if (myBalls[i]._name.indexOf("red") >= 0)
			{
				ballColours.push("red");
			}
			else if (myBalls[i]._name.indexOf("green") >= 0)
			{
				ballColours.push("green");
			}
			else if (myBalls[i]._name.indexOf("blue") >= 0)
			{
				ballColours.push("blue");
			}  
		}
		return ballColours;
	}
	
	public function hasAvailableSpot():Boolean
	{
		if (myBalls.length < positionsMax)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public function empty():Void
	{
		for (var i:Number = myBalls.length-1; i >= 0; i--)
		{
			myBalls[i].ownerStand = null;
			removeBall();
		}
	}
	
	public function init():Void
	{
		var standCenterX:Number = this._x+(this._width/2);
		var standBottomY:Number = this._y+this._height;
		myMarker.init(standCenterX,standBottomY);
		
		myNumber._x = this._x;
		myNumber._y = this._y - 20;
		
	}
	
	private function drawBalls():Void
	{
		var standCenterX:Number = this._x+(this._width/2);
		var standBottomY:Number = this._y+this._height;
		
		for (var i:Number = 0; i < myBalls.length; i++)
		{
			myBalls[i]._x = standCenterX;
			myBalls[i]._y = standBottomY - (myBalls[i]._height/2) - i*(myBalls[i]._height);
		}
	}
	
	public function addBall(ball:TowerBall):Boolean
	{
		if (myBalls.length == positionsMax)
		{
			trace("ERROR: Too many balls");
			return false;
		}
		else
		{
			for (var i:Number = 0; i < myBalls.length; i++)
			{
				myBalls[i].movable = false;
				myBalls[i].useHandCursor = false;
			}
			ball.movable = true;
			ball.ownerStand = this;
			myMarker.moveUp();
			myBalls.push(ball);
			drawBalls();
			return true;
		}
	}
	
	public function removeBall():Boolean
	{
		if (myBalls.length == 0)
		{
			trace("ERROR: No balls to remove");
			return false;
		}
		else
		{
			myBalls.pop();
			if (myBalls.length > 0)
			{
				myBalls[myBalls.length-1].movable = true;
				myBalls[myBalls.length-1].useHandCursor = true;
			}
			myMarker.moveDown();
			drawBalls();
			return true;
		}
	}
	
}