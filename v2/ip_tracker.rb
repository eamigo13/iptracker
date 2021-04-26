require 'singleton'
require './ip_address.rb'

class IPTracker
  include Singleton

  attr_reader :top100, :ips

  def initialize
    @ips = {}
    @top100 = []
  end

  def handle_request(ip)
    ips[ip] ||= IPAddress.new(ip)
    ip_address = ips[ip]
    ip_address.increment
    check_top100(ip_address)
    ip_address
  end

  def clear
    @ips = {}
    @top100 = []
  end

  private

    def check_top100(ip_address)
      return if ip_address.top100
      if top100.length < 100
        add_to_top100(ip_address)
      else
        lowest_ip = top100.last
        add_to_top100(ip_address) if ip_address.requests_received > lowest_ip.requests_received
      end
    end

    def add_to_top100(ip_address)
      if top100.length >= 100
        loser_ip = @top100.pop
        loser_ip.top100 = false
      end
      @top100 << ip_address
      ip_address.top100 = true
      sort_top100
    end

    def sort_top100
      @top100 = @top100.sort_by(&:requests_received).reverse
    end
end