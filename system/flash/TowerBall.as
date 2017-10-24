class TowerBall extends MovieClip
{
	public var ownerStand:Object;
	public var movable:Boolean;
	public var interactive:Boolean;
	private var isSelected:Boolean = false;

	public function selectBall(showNumbers:Boolean):Boolean
	{
		if (!movable || !interactive || isSelected) return false;
		
		isSelected = true;
		
		_level0.bringToFront(this);
		gotoAndStop(2);
		
		for (var i:Number = 0; i < _level0.allStands.length; i++)
		{
			if (_level0.allStands[i] != ownerStand && _level0.allStands[i].hasAvailableSpot())
			{
				if (showNumbers)
				{
					_level0.allStands[i].showNumber();
				}
				_level0.allStands[i].showMarker();
			}
		}
		return true;
	}
	
	public function deSelectBall():Boolean
	{
		if (!movable || !interactive || !isSelected) return false;
		
		gotoAndStop(1);
		isSelected = false;
		
		for (var i:Number = 0; i < _level0.allStands.length; i++)
		{
			_level0.allStands[i].hideNumber();
			_level0.allStands[i].hideMarker();
		}
		return true;
	}
	
	public function moveBall(standNumber:Number):Void
	{
		if (deSelectBall() == false) return;
		
		if (ownerStand == _level0.allStands[standNumber-1])
		{
			return;
		}
		else
		{
			ownerStand.removeBall();
			_level0.allStands[standNumber-1].addBall(this);
			_level0.usedMoves++;
			_level0.usedMoves_txt.text = "Used: "+_level0.usedMoves+" move";
			
			if (_level0.usedMoves > 1)
			{
				_level0.usedMoves_txt.text += "s";
			}
			
			_level0.checkResult();
			ownerStand.drawBalls();
		}
	}
	
	public function releaseBall():Void
	{
		if (deSelectBall() == false) return;
				
		var droppedOn:Object = eval(this._droptarget);
		this.stopDrag();
		
		for (var i:Number = 0; i < _level0.allStands.length; i++)
		{
			if (droppedOn == _level0.allStands[i].getMarker() ||
				(_level0.allStands[i] != ownerStand && _level0.allStands[i] == droppedOn))
			{
				ownerStand.removeBall();
				_level0.allStands[i].addBall(this);
				_level0.usedMoves++;
				_level0.usedMoves_txt.text = "Used: "+_level0.usedMoves+" move";
				if (_level0.usedMoves > 1)
				{
					_level0.usedMoves_txt.text += "s";
				}
				_level0.checkResult();
			}
		}
		ownerStand.drawBalls();
	}
	
	public function onPress()
	{
		if (selectBall(false))
		{
			this.startDrag();
		}
	}
	
	public function onRelease()
	{
		releaseBall()
	}
}