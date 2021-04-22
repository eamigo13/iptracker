require 'singleton'
require 'redis'
require 'faker'

class IPTracker
  include Singleton

  attr_reader :redis

  IP_COUNTS_KEY = 'ip_counts'.freeze

  def initialize
    @redis = Redis.new
  end

  def handle_request(ip_address)
    redis.zincrby(IP_COUNTS_KEY, 1, ip_address)
  end

  def top_ips(count=100, with_counts: false)
    index = count - 1
    redis.zrevrange(IP_COUNTS_KEY, 0, index, with_scores: with_counts)
  end

  def clear
    redis.del(IP_COUNTS_KEY)
  end

  def test(load_count=100000, unique_ips=load_count/5)
    fake_ips = unique_ips.times.map{Faker::Internet.public_ip_v4_address}
    handle_request_benchmarks = []
    load_count.times do
      ip_address = fake_ips.sample
      handle_request_benchmarks << benchmark{handle_request(ip_address)}
    end
    top100_benchmark = benchmark{top_ips}
    handle_request_benchmark = ((handle_request_benchmarks.sum/handle_request_benchmarks.size) * 1000).round(2)
    puts "Handle Request Benchmark: #{handle_request_benchmark} ms/request"
    puts "Top IPs Benchmark: #{(top100_benchmark * 1000).round(2)} ms"
  end

  private

    def benchmark
      start_time = current_time
      yield
      end_time = current_time
      end_time - start_time
    end

    def current_time
      Process.clock_gettime(Process::CLOCK_MONOTONIC) #https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/
    end
end