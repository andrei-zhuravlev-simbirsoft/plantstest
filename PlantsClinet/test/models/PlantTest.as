package models {

	import asunit.framework.TestCase;

	public class PlantTest extends TestCase {
		private var plant:Plant;

		public function PlantTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			plant = new Plant();
		}

		override protected function tearDown():void {
			super.tearDown();
			plant = null;
		}

		public function testInstantiated():void {
			assertTrue("plant is Plant", plant is Plant);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}