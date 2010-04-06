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

require 'test/unit'
require 'rubygems'
require 'shoulda'
require File.here / '..' / 'lib' / 'trazzler-api'
