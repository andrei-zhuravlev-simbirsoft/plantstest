package {
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import asunit.framework.TestSuite;
	import utils.*;
	import models.*

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new utils.SpriteLoaderTest());
			addTest(new utils.DataLoaderTest());
			addTest(new models.GameObjectTest());
			addTest(new models.IsoPointTest());
			addTest(new models.PlantStateTest());
			addTest(new models.PlantTest());
		}
	}
}
