def test(word)
  # letters = 10.times.map { ('A'..'Z').to_a.sample }
  letters = ["A", "Z", "U", "X"]

  word.upcase.chars.each do |letter|
    return false unless (index = letters.index(letter))
    letters[index] = 0
  end
  return true
end
