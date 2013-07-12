require 'connection'
require 'yaml'

# Load Settings.yml

settings = YAML::load_file("settings.yml")

# Make a Connection

con = Connection.new(settings["ae"],settings["port"],settings["ip"],settings["host_ae"])

# Echo the server

puts con.echo

