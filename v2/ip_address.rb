class IPAddress

  attr_reader :ip, :requests_received
  attr_accessor :top100

  def initialize(ip)
    @ip = ip
    @requests_received = 0
    @top100 = false
  end

  def increment
    @requests_received += 1
  end
end