#!/usr/bin/env ruby
class Bowling
  attr_accessor :score
  def initialize
    self.score = 0
  end
  def hit pin_count
    self.score += pin_count
  end

  private :score=
end
