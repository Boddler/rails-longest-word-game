require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    7.times do
      @letters << %w[b c d f g h j k l m n p q r s t v w x y z].sample.upcase
    end
    3.times do
      @letters << %w[a e i o u].sample.upcase
    end
  end

  def score
    x = 0
    @letters = params[:letters].split("")
    @answer = params[:answer].upcase.split("")
    @lettershash = @letters.inject(Hash.new(0)) { |total, letter| total[letter] += 1; total }
    @answerhash = @answer.inject(Hash.new(0)) { |total, letter| total[letter] += 1; total }
    @answerhash.each do |key, value|
      x += 1 if value > @lettershash[key]
    end
    api = URI.open("https://dictionary.lewagon.com/#{params[:answer]}")
    json = JSON.parse(api.read)
    if x > 0
      @result = "Sorry but your word can't be made from those letters."
    elsif x.zero? && json["error"]
      @result = "Sorry, but your word isn't a word."
    else
      score = json["length"]
      @result = "That's a valid word - great job! #{score} points!"
    end
  end
end
