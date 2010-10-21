class String
  def /(other)
    File.join(self, other)
  end
end

class File
  def self.here
    dirname(__FILE__)
  end
end

require File.here / '..' / 'lib' / 'trazzler-api'

require 'webmock/rspec'

RSpec.configure do |config|
  config.include WebMock::API
end
