package operations
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class MockOperation extends Operation
	{
		public var executionCount:int;

		private var _responseTimer:Timer;
		private var _fail:Boolean;

		public function MockOperation(responseTime:int = 0, fail:Boolean = false)
		{
			super();
			_fail = fail

			_responseTimer = new Timer(responseTime, 1);
			_responseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, handleResponseTimer);
		}

		private function handleResponseTimer(event:TimerEvent):void
		{
			if (_fail) {
				fault("FAIL");
			} else {
				result("RESULT");
			}
		}

		override protected function cancelRequest():void
		{
			super.cancelRequest();
			_responseTimer.reset();
		}

		override protected function performOperation():void
		{
			executionCount++;
			_responseTimer.reset();
			_responseTimer.start();
		}
	}
}
