package models
{
	public class IsoPoint
	{
		public var mX:int;
		public var mY:int;
		public var mZ:int;
		
		public function IsoPoint(x:int=0,y:int=0,z:int=0):void
		{
			this.mX = x;
			this.mY = y;
			this.mZ = z;
		}
		
		static public function isoToScreen (isoPt:IsoPoint, createNew:Boolean = false):IsoPoint
		{
			var z:Number = isoPt.mZ * Math.sqrt(1.25);
			var y:Number = 0.5 * (isoPt.mX + isoPt.mY) - isoPt.mZ;
			var x:Number = isoPt.mX - isoPt.mY;
			
			if (createNew)
				return new IsoPoint(x, y, z);
				
			else
			{
				isoPt.mX = x;
				isoPt.mY = y;
				isoPt.mZ = z;
				
				return isoPt;
			}
		}
		
		static public function screenToIso (screenPt:IsoPoint, createNew:Boolean = false):IsoPoint
		{
			var z:Number = screenPt.mZ / Math.sqrt(1.25);
			var y:Number = (2 * screenPt.mY - screenPt.mX) / 2 + screenPt.mZ;
			var x:Number = screenPt.mX + screenPt.mY;
			
			if (createNew)
				return new IsoPoint(x, y, z);
				
			else
			{
				screenPt.mX = x;
				screenPt.mY = y;
				screenPt.mZ = z;
				
				return screenPt;
			}
		}
	}
}