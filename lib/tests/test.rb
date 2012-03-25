# Default behavior for all test objects
# All tests should inherit from this base class

class Test
  def self.begin(test = nil)
    test = :default if test == nil

    if self.respond_to?(test)
      self.send(test)
    end
  end

  def self.default
    # override this method with your own test
    # all tests should have a default test, or
    # a default method that points to another test
  end
end
