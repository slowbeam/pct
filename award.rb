class Award
  attr_accessor :expires_in, :quality
  attr_reader :name
  BLUE_COMPARE = 'Blue Compare'.freeze
  BLUE_DISTINCTION_PLUS = 'Blue Distinction Plus'.freeze
  BLUE_FIRST = 'Blue First'.freeze
  BLUE_STAR = 'Blue Star'.freeze

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def calculate_quality
    return increment_quality if incrementable_award?

    decrement_quality
  end

  def calculate_expiration
    @expires_in -= 1
    handle_expired unless active?
  end

  private

  def decrement_quality
    return if @quality <= 0
    return @quality -= 2 if @name == BLUE_STAR

    @quality -= 1
  end

  def increment_quality
    return if @quality >= 50
    @quality += 1
    return if @name != BLUE_COMPARE || !active?

    @quality += 1 if @expires_in < 11
    @quality += 1 if @expires_in < 6
  end

  def incrementable_award?
    [BLUE_FIRST, BLUE_COMPARE].include?(name)
  end

  def handle_expired
    return @quality = 0 if @name == BLUE_COMPARE
    return decrement_quality unless @name == BLUE_FIRST

    increment_quality
  end

  def active?
    @expires_in >= 0
  end
end
