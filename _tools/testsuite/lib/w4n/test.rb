require 'w4n/assertions'

class W4NTest < Minitest::Test
  include Minitest::W4NAssertions
  def initialize x
    unless self.class.class_variable_defined? :@@global_setup_done
      global_setup if respond_to? :global_setup
      self.class.class_variable_set :@@global_setup_done,true
    end
    super
  end
  def result
    case failure
    when NilClass                   ; :passed
    when Minitest::UnexpectedError  ; :error
    when Minitest::Skip             ; :skipped
    when Minitest::Assertion        ; :failed
    end
  end
end
