package operations
{
	public class Retries
	{
		private var _attempt:uint;
		private var _retryCount:uint;
		private var _delays:Array;

		public function Retries(retryCount:uint)
		{
			_retryCount = retryCount;
			_delays = [];
		}

		internal function reattempt():int
		{
			_attempt++;
			return _delays[Math.min(_delays.length-1, _attempt-1)];
		}

		public function withDelay(...delays):void
		{
			_delays = delays.length > _retryCount ? delays.slice(0, _retryCount) : delays;
		}

		public function get canRetry():Boolean
		{
			return _attempt < _retryCount;
		}
	}
}
