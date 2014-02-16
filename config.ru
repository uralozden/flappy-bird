require './app'
enable :logging, :dump_errors, :raise_errors
run Sinatra::Application
