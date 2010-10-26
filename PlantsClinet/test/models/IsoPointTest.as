package models {

	import asunit.framework.TestCase;

	public class IsoPointTest extends TestCase {
		private var isoPoint:IsoPoint;

		public function IsoPointTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			isoPoint = new IsoPoint();
		}

		override protected function tearDown():void {
			super.tearDown();
			isoPoint = null;
		}

		public function testInstantiated():void {
			assertTrue("isoPoint is IsoPoint", isoPoint is IsoPoint);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}