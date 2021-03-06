ruby-semq

This is a ruby gem to support getting items from a semq queue and pushing items onto it. Due to the simplicity of the semq interface, there is only a single class with two methods.

Usage:

Create a new queue with the server location and queue name

    queue = new Semq("http://localhost:8080", "myMessageQueue")

Put an item in a queue.

    queue.push("A string")

Get the next item on the queue (blocking, will wait until there is an item to return).

    nextitem = queue.pop

pop will wait indefinitely for an item to be placed on the queue. If you wish to time out, there is an optional parameter, timeout_in_seconds. The function will return after your specified timeout but it can take longer than the specified timeout, as it will always be aligned with a return from the semq server.

Returns after roughly two minutes if no messages are put onto the queue

    nextitem = queue.pop(120)

If the semq server is configured with a 20s long polling time then the following will return after roughly twenty seconds, despite the 1s timeout

    queue.pop(1) 
