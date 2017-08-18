# Music Library
This repository holds the API to manage Albums and Tracks for a single user.
The `music-library-ui` repository has the front-end consumer app which lets users interact with this API.

## Installation
In order to install the Music Library App, it is necessary to have installed `ruby` (tested in version 2.3.4)  and `bundler`.

You only need to run bundle in order to install dependencies:
```
bundle
```

For more information on dependencies, check `Gemfile`.

## Run the server

Music Library App is a rack-base app, run in port 8000.
Details on the rack handler, check `config.ru` file.

Run the following command to the the app up and running:
```
rackup config.ru
```

## Architecture notes

- Requests lifecycle starts at `MusicLibrary::Application#call` (config/application.rb).
- Routes are registered to `Router` (lib/router.rb) throught a DSL in (config/routes.rb).
- Controllers are defined in /app/controllers/ and each controller inherits from `BaseController` (/lib/base_controller.rb). `BaseController` main responsabilities are: provide render tools and request-related data (such as parameters).
- Models are defined in /app/models/ and each model inherits from `ActiveRecord::Base`. `ActiveRecord::Base` provide the behaviour of (ActiveRecord Pattern)[https://en.wikipedia.org/wiki/Active_record_pattern] to all models.
- `Response` model at /lib/response.rb has the responsability to wrap the responses from controllers and shape it properly for rack interface.

## Test
This app uses Rspec for testing purposes. Execute the following command to run the whole test suite.

```
rspec spec
```

All the files involved in test are in folder `./spec`.

## Database

This app is working on Sqlite on development and testing purposes. I encourage use other relational databases for production environments.
Thanks to the usage of ActiveRecord, database settings can be changed through `config/database.yml`.

Both development and testing databases files are located under `db` folder. Both databases only have tables empty of data.


## TODO list

- [ ] URL with parameters (/albums/:id)
- [ ] URL with nested resources (/albums/:id/tracks)
- [ ] Test on Application Controllers

### Routes to be achived
Due to the embrionary router system, both nested resources and parameterized url, are not implemented.
The following routes are the ones expected on a REST API:

* /albums # GET | POST
* /albums/1 # DELETE
* /album/1/tracks # GET
* /tracks/ # POST
* /tracks/1 # DELETE

