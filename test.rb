require_relative "rule"
require "test/unit"

class TestSimple < Test::Unit::TestCase
 
  def test_simple
    assert(SimpleRule.new.check(2) )
    assert(SimpleRule.new.check(3) )
  end
 
end

class TestNull < Test::Unit::TestCase
    def test_null
        assert_equal(false,NullRule.new.check(2))
        assert_equal(false,NullRule.new.check(3))
    end
end

class TestMultiRule <Test::Unit::TestCase
    def setup
        @rule = MultiRule.new(3,"Fizz")
    end
 
    def teardown
    end

    def test_multi
        assert_equal(true,@rule.check(3))
        assert_equal(true,@rule.check(9))
        assert_equal(true,@rule.check(0))
    end

    def test_multi2
        assert_equal(false,@rule.check(4))
    end
        
end

class TestMember < Test::Unit::TestCase
    def setup
        @rule = MemberRule.new(3,"w")
    end

    def teardown
    end

    def test_member
        assert_equal(true, @rule.check(3))
        assert_equal(true, @rule.check(13))
    end

    def test_member1
        assert_equal(false, @rule.check(4))
    end
end

class TestMacroRule < Test::Unit::TestCase
    def setup
        rules = []
        rules << MultiRule.new(3,"w")
        rules << MemberRule.new(3,"w")
        @rule = MacroRule.new(rules)
    end

    def teardown
    end

    def test_macro
        assert_equal(true,@rule.check(3))
        assert_equal(true,@rule.check(13))
    end

    def test_macro1
        assert_equal(false,@rule.check(4))
        assert_equal(false,@rule.check(7))
    end
end

class TestIfRule < Test::Unit::TestCase
    def setup
        @rule1 = MultiRule.new(3,"w")
    end

    def teardown
    end

    def test_if
        rule = IfElseRule.new(SimpleRule.new,@rule1,NullRule.new)
        assert_equal(true,rule.check(3))
        assert_equal(true,rule.check(9))
    end

    def test_else
        rule = IfElseRule.new(NullRule.new,NullRule.new,@rule1) 
        assert_equal(true,rule.check(3))
        assert_equal(true,rule.check(9))
    end
end