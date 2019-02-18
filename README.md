Setup Database

`rake db:setup`

To Rub Migration

`rake db:migrate`

Start Ruby console

`rails c`

Start Rails Server

`rails s` # default is 3000 port.

or 

`puma -w 5` 

Run DB Migrate

`docker-compose run --rm website rails db:migrate`

To Deploy in Production (With Docker)

`script/deploy`

-> Installs Ruby 2.3.7
-> Latest Redis on port 6379
-> Runs Rails Puma with 5 Worker on port 3000