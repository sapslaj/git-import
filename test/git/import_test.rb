require 'test_helper'

class Git::ImportTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Git::Import::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
