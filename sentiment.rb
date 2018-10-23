def sentiment()
  lookup = Hash.new
  file = "movie_reviews.txt"
  data = '';

  File.foreach(file) do |line|
    data << line.downcase
  end

  data.split("\n").each do |review|
    score = review[0].to_i
    words = review[2..-1]

    filtered_words = ''
    words.chars.each do |word|
      if word.match(/^[[:alpha:]]+$/) || word == ' '
        filtered_words << word
      end
    end

    filtered_words.split(" ").each do |word|
      if !lookup.include?(word)
        lookup[word] = [score,1]
      else
        lookup[word][0] += score
        lookup[word][1] += 1
      end
    end
  end

  lookup
end

def calculate_sentiment(phrase)
  lookup = sentiment()
  total_score = 0
  num = 0
  phrase.split(" ").each do |word|
    if lookup.include?(word)
      total_score += lookup[word][0].to_f/lookup[word][1]
      num += 1
    end
    if num == 0
      return 0
    end
  end
  return total_score.to_f/num
end

def prompt()
  puts("Sentiment Analysis")
  puts("Please enter a sentence to get its overall sentiment value:")
  input = gets.chomp
  puts ('Calculating....')
  score = calculate_sentiment(input.downcase)
  if score == 0
    puts ("There was not enough data to compute sentiment.")
  else
    puts ("The overall sentiment score is #{score}")
  end
end

prompt()
