require 'set'


class WordChainer
attr_reader :dictionary


    def initialize(dictionary_file_name)
        @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
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
        @current_words = [source]
        @all_seen_words = {source => nil}

        until @current_words.empty? || @all_seen_words.key?(target)
            explore_current_words
        end
        @all_seen_words
        build_path(target)
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adj_word|
                next if @all_seen_words.key?(adj_word)
                @all_seen_words[adj_word] = current_word
                new_current_words << adj_word
            end
        end
    @current_words = new_current_words
    end

    def build_path(target)
        path_arr = []
        current_word = target
        until current_word.nil?
            path_arr << current_word
            current_word = @all_seen_words[current_word]
        end
        path_arr.reverse
    end

end


if $PROGRAM_NAME == __FILE__
W = WordChainer.new('dictionary.txt')
# p W.dictionary
# p W.adjacent_words('duck')
p W.run('duck', 'bust')
end
