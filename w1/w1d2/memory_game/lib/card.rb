class Card
  attr_reader :face

  def initialize(value)
    @value = value
    @face = false
  end

  def reveal
    @face = true
  end

  def to_s
    @value
  end

  def ==(other)
    self.to_s == other.to_s
  end

  def hide
    @face = false
  end

end
