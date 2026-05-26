# feature: class inheriting State, include Greetable, require, require_relative,
#          cross-file call, external call (puts must not produce local edge).

require "json"
require_relative "helpers"
require_relative "types"

class Service < State
  include Greetable

  def initialize(name)
    @name = name
  end

  def run
    greeting = Helpers.format_name(@name)
    puts greeting
  end

  def hi
    "hello from service"
  end
end
