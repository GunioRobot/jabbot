require 'rubygems'
if RUBY_VERSION =~ /1\.9/
  Gem.all_load_paths
  gem "thoughtbot-shoulda"
  gem "xmpp4r"
end
require 'test/unit'
require 'shoulda'
require File.join(File.dirname(__FILE__), '../lib/jabbot')

module Test::Unit::Assertions
  def assert_hashes_equal(expected, actual, message = nil)
    full_message = build_message(message, <<EOT, expected.inspect, actual.inspect)
<?> expected but was
<?>.
EOT
    assert_block(full_message) do
      break false if expected.keys.length != actual.keys.length
      expected.keys.all? { |k| expected[k] == actual[k] }
    end
  end

  def assert_hashes_not_equal(expected, actual, message = nil)
    full_message = build_message(message, <<EOT, expected.inspect, actual.inspect)
<?> expected but was
<?>.
EOT
    assert_block(full_message) do
      break false if expected.keys.length != actual.keys.length
      expected.keys.any? { |k| expected[k] != actual[k] }
    end
  end
end

Message = Struct.new(:user, :text, :time)
def message(user, text)
  Message.new(user, text, Time.now)
end
