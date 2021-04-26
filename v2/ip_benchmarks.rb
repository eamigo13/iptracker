require './ip_tracker.rb'

class IPBenchmarks

  attr_reader :ip_tracker
  attr_accessor :request_count, :benchmarks

  def initialize(request_count)
    @request_count = request_count
    @ip_tracker = IPTracker.instance
  end

  def run_benchmarks
    handle_request_benchmarks = []
    request_count.times.each_with_index do |e, i|
      puts i if i%10000 == 0
      ip_address = Faker::Internet.public_ip_v4_address
      handle_request_benchmarks << benchmark{ip_tracker.handle_request(ip_address)}
    end
    top100_benchmark = (benchmark{ip_tracker.top100} * 1000).round(4)
    handle_request_benchmark = ((handle_request_benchmarks.sum/handle_request_benchmarks.size) * 1000).round(4)
    @benchmarks = {
      handle_request: handle_request_benchmark,
      top100: top100_benchmark
    }
    write_benchmarks
  end

  def write_benchmarks
    puts "Handle Request Benchmark: #{benchmarks[:handle_request]} ms/request"
    puts "Top 100 Benchmark: #{benchmarks[:top100]} ms"
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