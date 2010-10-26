package utils {

	import asunit.framework.TestCase;

	public class URLBrockerTest extends TestCase {
		private var uRLBrocker:URLBrocker;

		public function URLBrockerTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			uRLBrocker = new URLBrocker();
		}

		override protected function tearDown():void {
			super.tearDown();
			uRLBrocker = null;
		}

		public function testInstantiated():void {
			assertTrue("uRLBrocker is URLBrocker", uRLBrocker is URLBrocker);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}