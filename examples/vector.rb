
class Vector2D
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def +(other)
    raise ArgumentError, "Expected Vector2D but got #{other.class}" unless other.is_a? Vector2D

    Vector2D.new(x + other.x, y + other.y)
  end
end
