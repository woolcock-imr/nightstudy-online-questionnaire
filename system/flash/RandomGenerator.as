class RandomGenerator
{
	private var _numRange:Number;
	private var _lastRandom:Number;
	
	//Constructor
	public function RandomGenerator(numRange:Number)
	{
		this._numRange = numRange;
		this._lastRandom = null;
	}
	
	public function setLastRandom(num:Number):Void
	{
		_lastRandom = num;
	}
	
	//Generate a random number within _numRange. Must be different to the last & unwanted.
	public function generateRandomNumber(unwanted:Number):Number
	{
		var randomNum:Number = Math.floor(Math.random()* _numRange);
	
		//if the random number produces a repeat result, get another one
		if (unwanted == null)
		{
			while (randomNum == _lastRandom)
			{
				randomNum = Math.floor(Math.random()* _numRange);
			}
		}
		else
		{
			while (randomNum == _lastRandom || randomNum == unwanted)
			{
				randomNum = Math.floor(Math.random()* _numRange);
			}
		}
		
		_lastRandom = randomNum;
		return randomNum;
	}
	
	//Generate a random array using each of the numbers from 0 to _numRange
	//returns a random array of lengthArr
	public function generateRandomArray(lengthArr:Number):Array
	{
		var randomArr:Array = new Array();
		var unusedArr:Array = new Array(_numRange);
		
		//Prepare list of numbers to use in random array
		for(var i:Number = 0; i < _numRange; i++)
		{
			unusedArr[i] = i;
		}
		
		//randomly select value from unusedArr and push onto randomArr
		for(var i:Number = 0; i < lengthArr; i++)
		{
			var randIndex:Number = Math.floor(Math.random()*unusedArr.length);
			randomArr.push(unusedArr[randIndex]);
			
			//copy unusedArr to tempArr, leaving out the value that was just pushed onto ranomArr
			var tempArr:Array = new Array();
			for(var j:Number = 0; j < unusedArr.length ; j++)
			{
				if (j != randIndex)
				{
					tempArr.push(unusedArr[j]);
				}
			}
			
			//clear unusedArr, and copy tempArr back to unusedArr
			unusedArr = new Array();
			for(var j:Number = 0; j < tempArr.length ; j++)
			{
				unusedArr.push(tempArr[j]);
			}
		}
		
		return randomArr;
	}
	
}