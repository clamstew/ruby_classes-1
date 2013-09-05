# exercise 27 - Convert the following methods to use the send method.

5.send(:*, 5) # 5 * 5
"omg".send(:upcase, "") # "omg".upcase()
['a', 'b', 'c'].send(:at, 1) # ['a', 'b', 'c'].at(1)
['a', 'b', 'c'].send(:insert, 2, 'o', 'h', 'n', 'o') #['a', 'b', 'c'].insert(2, 'o', 'h', 'n', 'o')
{}.send(:size) # {}.size()
{character: "Mario"}.send(:has_key?, :character) # {character: "Mario"}.has_key?(:character)

# exercise 28 - Convert the following methods to not use the send method.

6 - 32 # 6.send(:-, 32)
{html: true, json: false}.keys() # {html: true, json: false}.send(:keys)
"MakerSquare" * 6  # "MakerSquare".send(:*, :6)
"MakerSquare".split('a') # "MakerSquare".send(:split, 'a')
['alpha', 'beta'][3] # ['alpha', 'beta'].send(:[], 3)