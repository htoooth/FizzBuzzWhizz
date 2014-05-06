class Rule
    def check num
    end
end

class SimpleRule < Rule
    def check num
        print num
        return true
    end
end

class NullRule < Rule
    def check num
        return false
    end
end

class MultiRule < Rule
    def initialize num, desc
        @num = num
        @desc = desc
    end

    def check num
        if num % @num == 0
            print @desc
            return true
        end
        return false
    end
end

class MemberRule < Rule
    def initialize num,desc
        @num = num
        @desc = desc
    end

    def check num
        if num.to_s.include? @num.to_s
            print @desc
            return true
        end
        return false
    end
end

class MacroRule < Rule
    def initialize rules 
       @rules = rules 
    end

    def check num
        result = false
        @rules.each do |i|
            if i.check num
                result = true
            end
        end

        return result
    end
    
end

class IfElseRule < Rule
    def initialize prerule,left,right
        @prerule = prerule
        @right = right
        @left = left
    end

    def check num
        if @prerule.check num
            @left.check num
        else
            @right.check num
        end

    end
end 