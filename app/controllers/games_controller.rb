require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z')
    @grid = []
    10.times do
      @grid << @letters.to_a.sample
      end
    return @grid
  end

  def score
    @word = params[:input].upcase
    @grid = params[:grid].split
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary_serialized = open(@url).read
    @dictionary = JSON.parse(dictionary_serialized)
    word = @word.chars
    if @grid.permutation(@word.length).to_a.include?(word) == false
      @response = "Sorry but #{word.join.upcase} can't be built out of #{@grid.join(" ")}"
    elsif @dictionary["found"] == true
      @response = "Congratulations! #{@dictionary["word"].upcase} is a valid English word!"
    elsif @dictionary["found"] == false
      @response = "Sorry but #{@dictionary["word"].upcase} does not seem to be a valid word"
    end
  end
end
