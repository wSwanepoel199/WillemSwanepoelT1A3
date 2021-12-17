gem "tty-file"

require "tty-prompt"
prompt = TTY::Prompt.new
require "tty-file"

# TTY::File.create_file( "templates/test.txt", content="test")
test = TTY::File.binary?("templates/test.txt") # => true~
test2 = TTY::File.binary?("templates/test.png")
p test
p test2
file = File.read("templates/test.txt")
p file
prompt.yes?("Do you like Ruby?")