package models {

	import asunit.framework.TestCase;

	public class GameObjectTest extends TestCase {
		private var gameObject:GameObject;

		public function GameObjectTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			gameObject = new GameObject();
		}

		override protected function tearDown():void {
			super.tearDown();
			gameObject = null;
		}

		public function testInstantiated():void {
			assertTrue("gameObject is GameObject", gameObject is GameObject);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}