AS3 Operations is an Apache Flex library that provides a standardized API for working with synchronous and asynchronous operations.

## Usage

### Creating your own operation
Create custom operations by sub-classing `Operation`.

**Example:** An image resizing operation.

```as3
public class LoadAndResizeImageOperation extends Operation
{
	private var _imageUrl:String;
	private var _size:uint;

	private var _loader:Loader;

	public class LoadAndResizeImageOperation(imageUrl:String, size:uint)
	{
		super();

		_imageUrl = imageUrl;
		_size = size;

		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaderComplete);
		_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleLoaderError);
	}

	override protected function performOperation():void
	{
		_loader.load(new URLRequest(_imageUrl));
	}

	private function resizeImage(image:BitmapData):BitmapData
	{
		var newWidth:Number = ...
		var newHeight:Number = ...
		var transformation:Matrix = ...

		var resized:BitmapData = new BitmapData(newWidth, newHeight);
		resized.draw(image, transformation);
		return resized;
	}

	private function handleLoaderComplete(event:Event):void
	{
		result(resizeImage((_loader.content as Bitmap).bitmapData));
	}

	private function handleLoaderError(event:IOErrorEvent):void
	{
		fault(event);
	}
}
```

### Operation Queues
The operation queue lets you queue up a set of operations to execute. Queues support executing operations in parallel.

**Example:** Queueing up image resizers

```as3
var size:int = 400;

// A queue that will process 2 operations at a time.
var queue:OperationQueue = new OperationQueue(2);
queue.add( new LoadAndResizeImageOperation("http://mydomain.com/image1.jpg", size) );
queue.add( new LoadAndResizeImageOperation("http://mydomain.com/image2.jpg", size) );
queue.add( new LoadAndResizeImageOperation("http://mydomain.com/image3.jpg", size) );
queue.add( new LoadAndResizeImageOperation("http://mydomain.com/image4.jpg", size) );
queue.add( new LoadAndResizeImageOperation("http://mydomain.com/image5.jpg", size) );
queue.add( new LoadAndResizeImageOperation("http://mydomain.com/image6.jpg", size) );
queue.add( new LoadAndResizeImageOperation("http://mydomain.com/image7.jpg", size) );
queue.start();
```
