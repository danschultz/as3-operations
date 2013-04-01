package operations
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;

	public class OperationQueueTest
	{
		private var queue:OperationQueue;

		[Test(async)]
		public function testQueue():void
		{
			function handleTimeout(data:Object):void
			{
				fail();
			};

			queue = new OperationQueue();

			queue.addEventListener(OperationQueueEvent.IDLE,
					Async.asyncHandler(this, queueIdleHandler, 150, null, handleTimeout));
			queue.queue(new MockOperation(100));

			queue.start();
		}

		private function queueIdleHandler(event:FinishedOperationEvent, data:Object):void
		{
			assertEquals("If one operation has been added to queue, progress should be 100% after completion of that operation",
						0, queue.progress.total - queue.progress.confirmed);
		}

	}
}
