pluralizer.rb
=============

Artificial intelligence to turn singular nouns into their respective plural forms

To run from commandline
```sh
[maxwell@Orngcrsh:~/github/Pluralizer on master]
% ruby train.rb
```
```ruby
beer
Guess for Last_4_Letters_Heuristic:
===================================================
No matches found for beer
===================================================
Guess for Last_3_Letters_Heuristic:
===================================================
beer: beer
===================================================
Guess for Last_2_Letters_Heuristic:
===================================================
beer: beer
===================================================
```

Or file
```sh
[maxwell@Orngcrsh:~/github/Pluralizer on master]
% ruby train.rb
```
```ruby
Guess for Last_4_Letters_Heuristic:
===================================================
No matches found for class
fish: fish
No matches found for tomato
===================================================
Guess for Last_3_Letters_Heuristic:
===================================================
No matches found for class
fish: fishes
tomato: tomatoes
===================================================
Guess for Last_2_Letters_Heuristic:
===================================================
class: classes
fish: fishes
tomato: tomatoes
===================================================
```


##Training Data##
Looking for ANY sort of dataset on singular / plural words.  I can't seem
to find a good set unless I were to write a crawler.


##Development##

To write a heurstic, follow the code in heurstic.rb and implement
the train and guess functions.  In train.rb, be sure to add the heuristic
to the trainer class.
