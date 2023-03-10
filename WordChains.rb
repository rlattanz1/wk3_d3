require 'set'


class WordChainer
attr_reader :dictionary


    def initialize(dictionary_file_name)
        @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
        # @dictionary = Set.new(@dictionary)
    end

    def adjacent_words(word)
        adj_words = []
        word.each_char.with_index do |char, i|
            ('a'..'z').each do |new_char|
            next if char == new_char

            new_word = word.dup
            new_word[i] = new_char

            adj_words << new_word if dictionary.include?(new_word)
            end
        end
        adj_words
    end

    def run(source, target)
        new_current_words = []
        @current_words = [source]
        @all_seen_words = [source]

        until @current_words.empty?
            @current_words.each do |current_word|
                adjacent_words(current_word).each do |adj_word|
                new_current_words << adj_word if !@all_seen_words.include?(adj_word)
                end
            end
        end
    end

end


if $PROGRAM_NAME == __FILE__
W = WordChainer.new(dictionary.txt)
p W.dictionary

end
