This file contains instructions on how to run my solution.  It also includes benchmark information.  The [Write Up](#write-up) is found at the bottom of this file.

## Run

My solution uses Redis as an in-memory storage solution.  In order to run, please make sure your system is running redis and that you have the [redis](https://github.com/redis/redis-rb) gem installed.

Additionally, I use the [faker](https://github.com/faker-ruby/faker) gem to simulate IP addresses.  Please make sure this gem is installed as well.

Once your system is configured, run the following to load a ruby interpreter with the `IPTracker` class pre-loaded.

```
irb -r ./lib/ip_tracker.rb
```

### Handle Requests

This will track that a request from the given IP address has been received.
```ruby
IPTracker.instance.handle_request('147.182.82.67')
```

### Top Requests

To return a a list of IP addresses with the most requests, run
```ruby
IPTracker.instance.top_ips
```

You can customize how many IP addresses you want returned
```ruby
IPTracker.instance.top_ips(50)
```

You can also request that the number of requests for each IP is returned
```ruby
IPTracker.instance.top_ips(with_counts: true)
```

### Clear Tracker

To clear all IPs, run
```ruby
IPTracker.instance.clear
```

## Benchmarks

In order to run a benchmark test, run
```ruby
IPTracker.instance.test
```
By default, this will simulate 100,000 requests and will output the benchmarks for the `handle_request` and `top_ips` method.

Additionally, you can specify the number of simulated requests
```ruby
IPTracker.instance.test(100)
```

### Benchmark results

#### 100,000 Requests
```
Handle Request Benchmark: 0.1 ms/request
Top IPs Benchmark: 0.4 ms
```

#### 1,000,000 Requests
```
Handle Request Benchmark: 0.11 ms/request
Top IPs Benchmark: 0.42 ms
```

#### 100,000,000 Requests
```
Handle Request Benchmark: 0.11 ms/request
Top IPs Benchmark: 0.42 ms
```

## Write Up

### What would you do differently if you had more time?
I'd look into what error handling I need to include.  For example, what happens if an IP address is passed in with trailing spaces?  Should I handle it as a unique IP, or eliminate the trailing whitespace?  Should I validate that the IP addresses given are valid IPs?


### What is the runtime complexity of each function?
`handle_request` implements the redis `zincrby` method which has a time complexity of `O(log(N))` where N is the number of elements in the sorted set.

`top_ips` implements the redis `zrevrange` method which has a time complexity of `O(log(N)+M)` with N being the number of elements in the sorted set and M the number of elements returned.

`clear` implements the redis `del` method which.  We only delete one key which has a time complexity of O(1).

### How does your code work?
My code takes advantage of redis sorted sets to maintain a list of unique IPs and a count of how many times each IP has been handled.  Redis is an efficient in-memory storage solution that allows us to track large amounts of data in a speedy and efficient manner.

### What other approaches did you decide not to pursue?
I thought about writing my own in memory storage solution, but decided that taking advantage of Redis would be quicker, easier to mantain, and would probably be faster than any custom solution I could write.

### How would you test this?
I've written a test function into the code.  Please refrerence the [Benchmarks](#benchmarks) section.