#GIEC Relational Database Model

##Installation
Before any installation, be sure to have installed the following packages
```bash
sudo apt-get install libmysqlclient-dev
```

To run the model, you should install ruby 2.0 and rubygems (RVM is recommanded for this task). Hence, install dependencies with bundler:

```sh
gem install bundler
bundle install
```

This will install datamapper and its mysql adapter.

##Importing the database
From there, I will assume that you have with you the csv feed of the database (to put under feed/). Adapt the file `config/database.example.yml` with your db information and rename it to `config/database.yml`.

Then run the following command an wait (it usually takes 5-6 min).
```sh
./import
```

##MySQL or SQLite3
If you want to target either MySQL or SQLite3, you can fiddle the code present in `model/connection.rb`.

##Database Model
The datamapper model can be found under `model/model.rb`. You can use it to run complex queries on the database.
