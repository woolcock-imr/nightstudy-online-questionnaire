class TowerBallMarker extends MovieClip
{	
	private var focused:Boolean;

	public function init(standCenterX:Number, standBottomY:Number):Void
	{
		var markerRadius:Number = ((this._height/2)-5);
		this._x = standCenterX;
		this._y = standBottomY - markerRadius;
	}
	
	public function moveUp():Void
	{
		this._y -= (this._height-10);
	}
	
	public function moveDown():Void
	{
		this._y += (this._height-10);
	}
	
	/*public function expand():Void
	{
		if (!focused)
		{
			focused = true;
			this.gotoAndPlay(1);
			this._width += 10;
			this._height += 10;
		}
	}
	
	public function restore():Void
	{
		if (focused)
		{
			focused = false;
			this.gotoAndStop(1);
			this._width -= 10;
			this._height -= 10;
		}
	}*/
}