module RandomData
  def self.username
    first_name = word.downcase
    last_name = word.capitalize
    "#{first_name}#{last_name}"
  end

  def self.email
    "#{word}@#{word}.com"
  end

  def self.password
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(6..11)].join
  end

  def self.paragraph
    sentences = []
    rand(4..6).times do
      sentences << sentence
    end

    sentences.join(" ")
  end

  def self.sentence
    strings = []
    rand(3..8).times do
      strings << word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  def self.title
    strings = []
    rand(1..3).times do
      strings << word
    end

    sentence = strings.join(" ")
    sentence.capitalize
  end

  def self.word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end
end
