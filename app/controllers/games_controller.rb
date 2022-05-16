require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 15.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    word_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    @word_unserialized = JSON.parse(word_serialized)
    @letters = params[:letters].split
    build_result
  end

  def build_result
    if valid? && exist?
      @result =["Well played, your word was", @word, "build out of", params[:letters]]
    elsif !valid?
      @result ="Sorry but #{@word} can't be build out of #{params[:letters]}"
    elsif !exist?
      @result = "Sorry but #{@word} does not seem to be a valid english word"
    end
  end

  def valid?
    @word.upcase.chars.each do |letter|
      return false unless (index = @letters.index(letter))

      @letters[index] = 0
    end
  end

  def exist?
    @word_unserialized['found']
  end
end
