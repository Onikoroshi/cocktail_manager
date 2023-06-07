# COCKTAIL MANAGER

## Get Started:
- make sure you have postgres and ruby 2.7.5 installed
- run `bundle install` to get things going
- run `rails db:rebuild` to get the databases created. Make sure you set up a postgres user like what the database.yml file is expecting, or alter that file to user information of your choosing.

## Admin Pages
Very basic admin functionality is available at localhost:3000/admin. Use the default `admin@example.com` and `password` or alter the seeds file to create credentials of your choosing. There should already be some data in there, and you can change things around to your liking.

## API Endpoints

### `GET /api/search?index=<number>&limit=<number>&query=<string>`
This will get a collection of cocktail recipes and display them in a json format with abbreviated information (just id, name, category name, and image url).

The `query` is text you're searching for. It is case-independant (so "Julippe Cocktail" will match "julippe"), and it will make partial matches (so "Julippe Cocktail" will match "juli" or "tail"), but does respect spaces (so "Julippe Cocktail" will _not_ match "ippeco", but _will_ match "ippe co"). If no search value is entered, this will return an empty collection.

The `index` is the individual offset where the query will start. So, if you put in 3, it will start with the 3rd matching record and display accordingly. The default is 0.

The `limit` is how many records will be sent back to you - again starting at the offset given by the `index` parameter. The default is 10.


### `GET /api/detail?id=<number>`
This will attempt to find the cocktail recipe with the given ID number, and display more details about it, including the container used, the full instructions, and the name and measurement of all ingredients used, as well as all the information from the search endpoint. If an invalid ID is given, it will send back an error.
