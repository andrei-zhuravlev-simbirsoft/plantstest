package models {

	import asunit.framework.TestCase;

	public class PlantStateTest extends TestCase {
		private var plantState:PlantState;

		public function PlantStateTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			plantState = new PlantState();
		}

		override protected function tearDown():void {
			super.tearDown();
			plantState = null;
		}

		public function testInstantiated():void {
			assertTrue("plantState is PlantState", plantState is PlantState);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}