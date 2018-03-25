# Using recursion and the is_a? method,
# write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

def deep_dup(arr)
  arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
end

# make better change problem from class
# make_better_change(24, [10,7,1]) should return [10,7,7]
# make change with the fewest number of coins

# To make_better_change, we only take one coin at a time and
# never rule out denominations that we've already used.
# This allows each coin to be available each time we get a new remainder.
# By iterating over the denominations and continuing to search
# for the best change, we assure that we test for 'non-greedy' uses
# of each denomination.

def make_better_change(value, coins)
  coins_to_check = coins.select {|coin| coin <= value}
  return nil if coins_to_check.empty?
  solutions = []

  coins_to_check.sort.reverse.each do |coin|
    remainder = value - coin
    if remainder > 0
      remainder_solution = make_better_change(remainder, coins_to_check)
      solutions << [coin] + remainder_solution unless remainder_solution.nil?
    else
      solutions << [coin]
    end
  end
  solutions.sort_by!{|arr| arr.size}.first
end

# return b^n recursively. Your solution should accept negative values
# for n
def exponent(b, n)
  return 1 if n == 0
  if n > 0
    b * exponent(b, n - 1)
  else
    1.0/b * exponent(b, n + 1)
  end
end

# Implement a method that finds the sum of the first n
# fibonacci numbers recursively. Assume n > 0
def fibs_sum(n)
  return 0 if n == 0
  return 1 if n == 1
  fibs_sum(n - 1) + fibs_sum(n - 2) + 1
end

#returns all subsets of an array
def subsets(array)
  return [[]] if array.empty?
  subs = subsets(array[0..-2])
  subs.concat(subs.map {|el| el += [array.last]})
end

# Write a recursive method that returns all of the permutations of an array
def permutations(array)
  return [array] if array.length <= 1
  first = array.shift
  perms = permutations(array)
  total_permutations = []

  perms.each do |perm|
    (0..perm.length).each do |i|
      total_permutations << perm[0...i] + [first] + perm[i..-1]
    end
  end
  total_permutations.sort
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  factorials_rec(num - 1) << factorials_rec(num - 1).last * (num - 1)
  # facs = factorials_rec(num - 1)
  # facs << facs.last * (num - 1)
  # facs
end

# Write a recursive method that takes in a string to search and a key string.
# Return true if the string contains all of the characters in the key
# in the same order that they appear in the key.
#
# string_include_key?("cadbpc", "abc") => true
# string_include_key("cba", "abc") => false
def string_include_key?(string, key)
  return true if key.length == 0
  next_key_char = key.chars.first
  key_index = string.index(next_key_char)

  return false if key_index.nil?
  string_include_key?(string[key_index + 1..-1], key[1..-1])
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
  root = 0
  while num > 0
    root += num % 10
    num = num / 10
  end
  while root > 9
    root = digital_root(root)
  end
  root
end

# Write a recursive function that returns the prime factorization of
# a given number. Assume num > 1
#
# prime_factorization(12) => [2,2,3]
def prime_factorization(num)
  return [] if num == 1
  (2..Math.sqrt(num).ceil).each do |i|
    if num % i == 0
      return [i] + prime_factorization(num / i)
    end
  end
  return [num]

end

def is_prime?(num)

end

# return the sum of the first n even numbers recursively. Assume n > 0
def first_even_numbers_sum(n)
  evens = []
  n.times { |i| evens << (i + 1) * 2 }
  evens.inject(&:+)
end

# CHALLENGE: Eight queens puzzle precursor
#
# Write a recursive method that generates all 8! possible unique ways to
# place eight queens on a chess board such that no two queens are in
# the same board row or column (the same diagonal is OK).
#
# Each of the 8! elements in the return array should be an array of positions:
# E.g. [[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]]
#
# My solution used 3 method parameters: current_row, taken_columns, and
# positions so far
def eight_queens_possibilities(current_row, taken_columns, positions)
  positions ||= []
  return [positions] if current_row == 8

  all_positions = []
  columns_left = (0..7).to_a - taken_columns

  columns_left.each do |col|
    positions_dup = positions.dup
    positions_dup << [current_row, col]

    all_positions += eight_queens_possibilities(current_row + 1, taken_columns + [col], positions_dup)
  end
  all_positions
end

# Write a recursive method that returns the sum of all elements in an array
def rec_sum(nums)
  return 0 if nums.length.zero?
  nums.shift + rec_sum(nums)
end

# Write a recursive method that takes in a base 10 number n and
# converts it to a base b number. Return the new number as a string
#
# E.g. base_converter(5, 2) == "101"
# base_converter(31, 16) == "1f"

def base_converter(num, b)
  return "" if num == 0
  digits = ('0'..'9').to_a + ('a'..'f').to_a
  base_converter(num/b, b) + digits[num % b]
end

class Array

  # Write a monkey patch of binary search:
  # E.g. [1, 2, 3, 4, 5, 7].my_bsearch(5) => 4
  def my_bsearch(target, &prc)
    return nil if size == 0
    mid = size/2
    case self[mid] <=> target
    when 0
      return mid
    when 1
      return self.dup.take(mid).my_bsearch(target)
    else
      search_res = self.dup.drop(mid+1).my_bsearch(target)
      search_res.nil? ? nil : mid + 1 + search_res
    end
  end

end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  factors = []
  (1..num).each do |n|
    factors << n if (num % n).zero?
  end
  factors
end

class Array

  # Takes a multi-dimentional array and returns a single array of all the elements
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,5]
  def my_flatten
    flattened = []
    each { |el| el.is_a?(Array) ? flattened += el.my_flatten : flattened << el }
    flattened
  end

  # Write a version of flatten that only flattens n levels of an array.
  # E.g. If you have an array with 3 levels of nested arrays, and run
  # my_flatten(1), you should return an array with 2 levels of nested
  # arrays
  #
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,[5]]
  def my_controlled_flatten(n)
    return self if n < 1
    result = []
    each do |el|
      if el.is_a?(Array)
        result += el.my_controlled_flatten(n - 1)
      else
        result << el
      end
    end
    result
  end
end

class Array

  def my_reverse
    reversed = []
    each { |el| reversed.unshift(el) }
    reversed
  end

end

# Write a method that returns the median of elements in an array
# If the length is even, return the average of the middle two elements
class Array
  def median
    return nil if empty?
    sorted = self.sort
    if length.odd?
      sorted[length / 2]
    else
      (sorted[length / 2] + sorted[length / 2 - 1]).fdiv(2)
    end
  end
end

class Array

  def my_join(str = "")
    to_string = ''
    self[0...(length - 1)].each do |el|
      to_string << el << str
    end
    to_string << self.last
    to_string
  end

end

class Hash

  # Write a version of merge. This should NOT modify the original hash
  def my_merge(hash2)
    copy = self.dup
    hash2.keys.each do |key|
      copy[key] = hash2[key]
    end
    copy
  end

end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2..Math.sqrt(num).round).none? { |n| (num % n).zero? }
end

def primes(num)
  primes = []
  prime_seed = 2
  until primes.length == num
    primes << prime_seed if is_prime?(prime_seed)
    prime_seed += 1
  end
  primes
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    dups = Hash.new { |hash, key| hash[key] = [] }
    my_each_with_index { |el, idx| dups[el] << idx if count(el) > 1}
    dups
  end
end

class Array

  def my_rotate(num=1)
    copy = self.dup
    (num % size).times { copy.push(copy.shift) }
    copy
  end

end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    two_sums = []
    each_index do |idx|
      each_index do |idx2|
        if (self[idx] + self[idx2]).zero? && idx != idx2 && two_sums.none? { |el| el == [idx2, idx]}
          two_sums << [idx, idx2]
        end
      end
    end
    two_sums
  end
end

# Write a method that capitalizes each word in a string like a book title
# Do not capitalize words like 'a', 'and', 'of', 'over' or 'the'
def titleize(title)
  little_words = ['a', 'and', 'of', 'over', 'the']
  titleized = []
  title.split(' ').my_each_with_index do |word, idx|
    if little_words.include?(word) && !idx.zero?
      titleized << word
    else
      titleized << word.capitalize
    end
  end
  titleized.join(' ')
end

# Write a method that translates a sentence into pig latin. You may want a helper method.
# 'apple' => 'appleay'
# 'pearl' => 'earlpay'
# 'quick' => 'ickquay'
def pig_latinify(sentence)
  translated_words = sentence.split(' ').map do |word|
    translate_word(word)
  end
  translated_words.join(" ")
end

def translate_word(word)
  vowels = %w(a e i o u)
  if vowels.include?(word[0])
    "#{word}ay"
  else
    phoneme_end = 0
    until vowels.include?(word[phoneme_end])
      phoneme_end += 1
    end
    phoneme_end += 1 if word[phoneme_end - 1] == 'q'
    "#{word[phoneme_end..-1]}#{word[0...phoneme_end]}ay"
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    symsubs = []
    chars.each_index do |start|
      chars.each_index do |stop|
        symsub = self[start..stop]
        symsubs << symsub if symsub == symsub.reverse && symsub.length > 1
      end
    end
    symsubs
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    subwords = []
    dictionary.each do |word|
      subwords << word unless self.index(word).nil?
    end
    subwords
  end
end

# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  code = ('a'..'z').to_a
  new_code = ''
  str.chars.each do |ch|
    if code.index(ch.downcase).nil?
      new_code << ch
    else
      new_code << code[(code.index(ch.downcase) + shift) % 26]
    end
  end
  new_code
end

class Hash

  # Write a version of my each that calls a proc on each key, value pair
  def my_each(&prc)
    keys.each do |key|
      prc.call(key, self[key])
    end
    self
  end

end

class Array

  def my_any?(&prc)
    any = false
    each { |el| any = true if prc.call(el) }
    any
  end

end

# Write a method that doubles each element in an array
def doubler(array)
  array.map { |el| el * 2 }
end

class Array

  def my_each(&prc)
    size.times do |i|
      prc.call(self[i])
    end
    self
  end

  def my_each_with_index(&prc)
    size.times do |i|
      prc.call(self[i], i)
    end
    self
  end

end

class Array

  def my_zip(*arrs)
    result = []
    (0...size).each do |idx|
      result << [self[idx]]
      arrs.each do |arr|
        result[idx] << arr[idx]
      end
    end
    result
  end

end

class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    prc ||= proc { |a, b| a + b }
    copy = self.dup
    accumulator ||= copy.shift
    copy.each { |el| accumulator = prc.call(accumulator, el) }
    accumulator
  end
end

class Array

  def my_select(&prc)
    selected = []
    each { |el| selected << el if prc.call(el) }
    selected
  end

end

class Array

  def my_reject(&prc)
    rejected = []
    each { |el| rejected << el unless prc.call(el) }
    rejected
  end

end

class Array

  def my_all?(&prc)
    all = true
    each { |el| all = false unless prc.call(el) }
    all
  end

end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  alphabet ||= ('a'..'z').to_a
  sorted = false
  until sorted
    sorted = true
    str.length.times do |i|
      break if i == (str.length - 1)
      if alphabet.index(str[i]) > alphabet.index(str[i + 1])
        str[i], str[i + 1] = str[i + 1], str[i]
        sorted = false
      end
    end
  end
  str
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    return self if size <= 1
    prc ||= proc { |x, y| x <=> y }
    middle = size / 2
    sorted_left = self[0...middle].merge_sort(&prc)
    sorted_right = self[middle...size].merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []
    until left.empty? || right.empty?
      if prc.call(left, right) < 0
        merged << left.shift
      else
        merged << right.shift
      end
    end
    merged + left + right
  end
end

class Array
  def bubble_sort!(&prc)
    sorted = false
    prc ||= proc { |x, y| x <=> y }
    until sorted
      sorted = true
      each_index do |i|
        next if i + 1 == self.length
        j = i + 1
        if prc.call(self[i], self[j]) > 0
          self[i], self[j] = self[j], self[i]
          sorted = false
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    prc ||= proc { |x, y| x <=> y }
    copy = self.dup
    copy.bubble_sort!(&prc)
  end
end

class Array

  #Write a monkey patch of quick sort that accepts a block
  def my_quick_sort(&prc)
    prc ||= proc { |a, b| a <=> b}
    return self if size < 2
    pivot = first
    left = self[1..-1].select { |el| prc.call(el, pivot) == -1}
    right = self[1..-1].select { |el| prc.call(el, pivot) != -1}
    left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)
  end

end
