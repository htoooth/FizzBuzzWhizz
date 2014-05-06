require_relative  'rule'

fizz = ARGV[0].to_i
buzz = ARGV[1].to_i
whizz = ARGV[2].to_i

multi_rule = []
multi_rule << MultiRule.new(fizz,"Fizz")
multi_rule << MultiRule.new(buzz,"Buzz")
multi_rule << MultiRule.new(whizz,"Whizz")

member_rule = []
member_rule << MemberRule.new(fizz,"Fizz")
member_rule << MemberRule.new(buzz,"Buzz")
member_rule << MemberRule.new(whizz,"Whizz")

multi_rules = MacroRule.new(multi_rule)
member_rules = MacroRule.new(member_rule)

rules = IfElseRule.new(member_rules, NullRule.new,
                                   IfElseRule.new(multi_rules,
                                        NullRule.new,
                                        SimpleRule.new))

(1..130).each { |n| print "#{n} == ";rules.check n;puts  }