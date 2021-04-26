This file contains instructions on how to run my solution.  It also includes benchmark information.  The [Write Up](#write-up) is found at the bottom of this file.  Note, this readme includes updated code based on the feedback I received.  The new code is in the v2 directory and the old code is in the lib directory.

## Run

```
irb -r ./v2/ip_tracker.rb
```

### Handle Requests

This will track that a request from the given IP address has been received.
```ruby
IPTracker.instance.handle_request('147.182.82.67')
```

### Top 100

To return a a list of IP addresses with the most requests, run
```ruby
IPTracker.instance.top100
```

### Clear Tracker

To clear all IPs, run
```ruby
IPTracker.instance.clear
```

## Benchmarks

In order to run a benchmark test, run the following in IRB
```ruby
require './v2/ip_benchmarks.rb'
bench = IPBenchmarks.new(1000000)
bench.run_benchmarks
```

### Benchmark results

#### 1,000,000 Requests
```
Handle Request Benchmark: 0.0031 ms/request
Top 100 Benchmark: 0.001 ms
```

## Write Up

### What would you do differently if you had more time?
I'd be curious in creating a method that allows us to get the top ips more dynamically.  i.e. how could I get the top 200 instead of the top 100?


### What is the runtime complexity of each function?
`handle_request` uses a hash key lookup (which is indexed) so has O(1) complexity.  In addition, it potentially resorts the top100 useing the ruby sort_by method which has a O(n log n) time complexity

`top_100` just return a presorted arrray so has a time complexity of O(1)

`clear` implements resets some variables to an empty hash and empty array which has a time complexity of O(1).

### How does your code work?
My code uses a ruby hash to maintain a dictionary with the ip address as a key and an IPAddress object (which includes request count) as an object.  This allows for quick and efficient lookups.

For the top100, I maintain an array of IPAddress objects.  After each request is handled, I check if the most recent ip has a higher request count than the lowest top100.  If its higher, I replace the lowest top100 with the current IP.

### What other approaches did you decide not to pursue?
I used this approach instead of using Redis as directed.

### How would you test this?
I've written a benchmark class into the code.  Please refrerence the [Benchmarks](#benchmarks) section.