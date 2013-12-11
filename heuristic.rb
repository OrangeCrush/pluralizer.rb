#  This class is used as a base class for heuristics
#  determining whether or not a word is plural
class Heuristic

   # @data will be the training set in the following format
   # [...[singular_word, plural_word], ...]
   # Rules will be /regexp1/ => [ /regexp2/, replace_str]
   # Where
   #  regexp1 is the regex defining how to match a word to thisn rule
   #  regexp2 is the regex that defines what part of the word needs to be replaced with the string replace_str
   def initialize(training_set)
      @training_set = training_set
      @rules = {}
      @metrics = {}
   end

   # train should read @training_set and then build @rules
   def train
      raise "Calling Abstract method train on class Heuristic."
   end

   # Guess the plural form of singular word using @rules!
   def guess(singular_word)
      raise "Calling Abstract method guess(#{singular_word}) on class Heuristic."
   end

   # Helper method to return an array in the form of
   # [string_to_replace, replace_str]
   def stringDiff(singular, plural)
      if !singular.empty? && !plural.empty? && singular[0] == plural[0]
         stringDiff(singular[1..-1], plural[1..-1])
      else
         return [singular, plural]
      end
   end

   # Should display random metrics
   def report
      raise "Calling Abstract method report on class Heuristic."
   end
end

class Last_N_Letters_Heuristic < Heuristic
   attr_accessor :name
   def initialize(training_set, numLetters)
      @N = numLetters #The greatest number of letters to look back
      @name = "Last_#{@N}_Letters_Heuristic"
      super(training_set)
   end

   def train
      @training_set.each do |x|
         regex_str = ""
         singular = x[0]
         plural   = x[1]
         if singular.size < @N
            regex_str = singular
         else
            regex_str = singular[-@N..-1]
         end
         regex = Regexp.new("#{regex_str}$")
         if @rules[regex].nil?
            # push the fitness on to 1
            @rules[regex] = stringDiff(singular, plural).push(1)
         else
            # add one to the fitness
            @rules[regex][2] += 1
         end
      end
   end

   def guess(singular_word)
      matches = []
      @rules.keys.each do |x|
         if singular_word =~ x
            matches << x
         end
      end
      possible_matches = []
      matches.each do |x|
         #@rules[x][0] is the string to replace, [x][1] is the string what to replace it with
         if @rules[x][0].empty?
            possible_matches <<  singular_word + @rules[x][1]
         else
            # might not replace last occurence..
            possible_matches << singular_word.replacelast!(@rules[x][0], @rules[x][1])
         end
      end
      return possible_matches.empty? ? "No matches found for #{singular_word}" : "#{singular_word}: #{fitness(possible_matches)}"
   end

   # will determine which match to used based on the fitness
   def fitness(matches)
      max_match = matches[0]
      matches.each do |match|
         if max_match[2] < match[2]
            max_match = match
         end
      end
      return max_match
   end
end

class String
   def replacelast!(old, new)
      self.reverse.sub!(old.reverse, new.reverse).reverse
   end
end
