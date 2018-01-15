class StringChanger
    def reverse_and_save(string_to_reverse)
        string_to_reverse.reverse.tap do |reversed_string|
            File.write('example_file', reversed_string)
        end
    end
end