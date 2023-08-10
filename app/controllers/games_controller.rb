class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << rand(65..90).chr
    end
  end

  def score
    x = 0
    @letters = params[:letters].split("")
    @answer = params[:answer].upcase.split("")
    @lettershash = @letters.inject(Hash.new(0)) { |total, letter| total[letter] += 1;total }
    @answerhash = @answer.inject(Hash.new(0)) { |total, letter| total[letter] += 1;total }
    @answerhash.each do |key, value|
      x += 1 if value > @lettershash[key]
    end
    api = {}
    api = HTTParty.get('https://wagon-dictionary.herokuapp.com/#{params[:answer]}')
    if x > 0
    @result = "Sorry but your word can't be made from those letters."
    elsif condition
      raise
    else
      @result = "That's a valid word - great job!"
    end
  end

end
