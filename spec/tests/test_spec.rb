require 'string_changer_spec'

describe StringChanger do
    it 'reverses strings' do
        string_changer = StringChanger.new
    
        reversed_string = string_changer.reverse_and_save('example string')
    
        expect(reversed_string).to eq 'gnirts elpmaxe'
    end

    it 'saves string to the file system' do
        string_changer = StringChanger.new
        File.stub(:write)
      
        string_changer.reverse_and_save('example string')
      
        expect(File).
            to have_received(:write).
            with('example_file', 'gnirts elpmaxe').
            once
    end
end
