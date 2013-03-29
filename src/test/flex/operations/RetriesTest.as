package operations
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class RetriesTest
	{
		[Test]
		public function testReattemptWithoutDelay():void
		{
			var retries:Retries = new Retries(3);
			assertThat(retries.reattempt(), equalTo(0));
			assertThat(retries.reattempt(), equalTo(0));
			assertThat(retries.reattempt(), equalTo(0));
			assertThat(retries.reattempt(), equalTo(NaN));
		}

		[Test]
		public function testReattemptWithSameDelay():void
		{
			var retries:Retries = new Retries(3).withDelay(5);
			assertThat(retries.reattempt(), equalTo(5));
			assertThat(retries.reattempt(), equalTo(5));
			assertThat(retries.reattempt(), equalTo(5));
			assertThat(retries.reattempt(), equalTo(NaN));
		}

		[Test]
		public function testReattemptWithDifferentDelays():void
		{
			var retries:Retries = new Retries(3).withDelay(5, 10, 15, 20);
			assertThat(retries.reattempt(), equalTo(5));
			assertThat(retries.reattempt(), equalTo(10));
			assertThat(retries.reattempt(), equalTo(15));
			assertThat(retries.reattempt(), equalTo(NaN));
		}

		[Test]
		public function testCanRetry():void
		{
			var retries:Retries = new Retries(1).withDelay(5);
			retries.reattempt();
			assertThat(retries.canRetry, equalTo(false));
		}
	}
}
