# Simple Web Service
My first idea was to use Rails Api Mode for this task, but it still looks like overkill for such simple task.
So I choose Sinatra as it is fast, simple and do the thing :)

# Set up
`bundle install`

# Start app:

`bundle exec rackup`

# Example of response

by default, after starting an app, it will listen to 9292 port. 
To try out some requests you could run something like this in you terminal:

`curl -H "Content-type: application/json" -X POST  -d '{"timestamp": 1234567, "data":[{"title":"Part1", "values":[1,2,3]},{"title":"Part2","values":[0,1,2]}]}' http://127.0.0.1:9292/compute/test`

# Run tests

`rspec spec`



