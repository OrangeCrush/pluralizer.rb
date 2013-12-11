# Serves as a main class for the plural AI system.

require './heuristic'

class Trainer
   attr_accessor :heuristics
   def initialize()
      @heuristics = []
   end

   def add_heuristic(h)
      @heuristics << h
   end

   # call train on each of the passed heuristics
   def run()
      heuristics.each do |x|
         x.train
      end
   end
end

# Read a file in the form of 
#
# singular plural
# .
# .
#
# As a data set
def read_data_set(file)
   raw_data =  File.readlines(file)
   training_set = []
   raw_data.each do |x|
      training_set << x.split(/\s+/).each{|word| word.chomp!; word.downcase!}
   end
   return training_set
end

main = Trainer.new

training_set = read_data_set("validation/train.txt")

main.add_heuristic(Last_N_Letters_Heuristic.new(training_set, 4))
main.add_heuristic(Last_N_Letters_Heuristic.new(training_set, 3))
main.add_heuristic(Last_N_Letters_Heuristic.new(training_set, 2))

main.run

data = []
ARGF.each do |input|
  input.downcase!
  input.chomp!
  data << input 
end

main.heuristics.each do |x|
   puts "Guess for #{x.name}:"
   puts "==================================================="
   data.each do |y|
      puts x.guess(y)
   end
   puts "==================================================="
end
