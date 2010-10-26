package utils {

	import asunit.framework.TestCase;

	public class DataLoaderTest extends TestCase {
		private var imgLoader:ImgLoader;

		public function DataLoaderTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			imgLoader = new ImgLoader();
		}

		override protected function tearDown():void {
			super.tearDown();
			imgLoader = null;
		}

		public function testInstantiated():void {
			assertTrue("imgLoader is ImgLoader", imgLoader is ImgLoader);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}