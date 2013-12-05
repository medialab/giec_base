# -------------------------------------------------------------------
# Giec Database Connection
# -------------------------------------------------------------------
#
#
#   Author : PLIQUE Guillaume
#   Organization : Medialab - Sciences Po
#   Version : 1.0

# Dependencies
require 'rubygems'
require 'data_mapper'

# Database Connection
#=====================
cd = File.dirname(__FILE__)

# Loading config
config = YAML::load(File.open(cd+'/../config/database.yml', 'r'))

# Returning database connection
# DataMapper.setup(:default, "mysql://#{config['user']}:#{config['password']}@#{config['host']}:#{config['port']}/#{config['database']}")
DataMapper.setup(:default, "sqlite:giec.db")