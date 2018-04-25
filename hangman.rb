def game_screen(wrong_guesses, guessed_letters, player_word)
  if wrong_guesses > 0
	puts "\n_____"
  else
	puts ""
  end
  print "|"
  if wrong_guesses > 1
	puts "   |"
  else
	puts ""
  end
  print "|"
  if wrong_guesses > 2
	puts "   O"
  else
    puts ""
  end
  print "|"
  if wrong_guesses == 4
    puts "  \\"
  elsif wrong_guesses > 4
    puts "  \\ /"
  else
    puts ""
  end
  print "|"
  if wrong_guesses == 6
	puts "  /"
  elsif wrong_guesses > 6
	puts "  / \\"
  else
	puts ""
  end
  print "\nGuessed letters: "
  i = 0
  while i < guessed_letters.length
	print "#{guessed_letters[i].upcase}, "
	i += 1
  end
  puts "\nWord: #{player_word}"
end

def guessed_new_letter? (guess, guessed_letters)
  i = 0
  while(i < guessed_letters.length)
	if guessed_letters[i] == guess
	  puts "You have already tried to guess this letter"
      return false
    end
	i += 1
  end
  unless guess =~ /[[:alpha:]]/
    puts "Entered character isn't a letter"
	return false
  end
  return true
end

def guess_correct? (word, guess)
  i = 0
  while (i < word.length)
    if guess.upcase == word[i].upcase
      return true
	end
	i += 1
  end
  return false
end
MAX_GUESSES = 7
word = File.read('5desk.txt').lines.select {|l| (4..9).cover?(l.strip.size)}.sample.strip

puts word

player_word = "_ _ _ _"
j = 0
i = 4
while i < word.length
  player_word += " _"
  i += 1
end

guessed_letters = Array.new
wrong_guesses = 0

until player_word == word || wrong_guesses >= MAX_GUESSES
  game_screen(wrong_guesses, guessed_letters, player_word)
  guess = gets.chomp[0]
  unless (guessed_new_letter?(guess, guessed_letters))
	next
  end
  guessed_letters.push guess
  if (guess_correct?(word, guess))
	player_letters = player_word.split
	while (j < word.length)
	  if guess == word[j]
	    if (j == 0)
	      player_letters[j] = guess.upcase
	    else
	      player_letters[j] = guess.downcase
	    end
	  end
	  j += 1
	end
	player_word = player_letters.join(" ")
	puts "Correct!"
	j = 0
  else
	wrong_guesses += 1
	puts "Wrong!"
  end
end

if wrong_guesses < MAX_GUESSES
  puts "You win!"
else
  game_screen(wrong_guesses, guessed_letters, player_word)
  puts "The word was #{word}"
  puts "Game over"
end
