package operations
{
	import org.flexunit.assertThat;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;

	public class OperationTest
	{
		[Test(async)]
		public function testRetry():void
		{
			function handleTimeout(data:Object):void
			{
				fail();
			};

			function handleOperationFinished(event:FinishedOperationEvent, data:Object):void
			{
				assertThat(operation.executionCount, equalTo(4));
			};

			var operation:MockOperation = new MockOperation(0, true);
			operation.retries(3);
			operation.addEventListener(FinishedOperationEvent.FINISHED, Async.asyncHandler(this, handleOperationFinished, 200, null, handleTimeout))
			operation.execute();
		}

		[Test(async)]
		public function testTimeout():void
		{
			function handleTimeout(data:Object):void
			{
				fail();
			};

			var didFault:Boolean = false;
			function handleOperationFault(event:FaultOperationEvent):void
			{
				didFault = true;
			};

			function handleOperationFinished(event:FinishedOperationEvent, data:Object):void
			{
				assertThat(operation.executionCount, equalTo(4));
				assertThat(didFault, equalTo(true));
			};

			var operation:MockOperation = new MockOperation(100, false);
			operation.timeout = 50;
			operation.retries(3);
			operation.addEventListener(FaultOperationEvent.FAULT, handleOperationFault);
			operation.addEventListener(FinishedOperationEvent.FINISHED, Async.asyncHandler(this, handleOperationFinished, 1000, null, handleTimeout))
			operation.execute();
		}
	}
}
