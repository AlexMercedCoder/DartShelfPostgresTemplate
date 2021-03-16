# Shelf Web Framework Template
##### by Alex Merced of AlexMercedCoder.com

## Cloning the Template

`git clone https://github.com/AlexMercedCoder/DartShelfPostgresTemplate.git projectName`

or if you have NPM

`npx degit AlexMercedCoder/DartShelfPostgresTemplate#main projectName`

## Folder Structure

- server.dart: the entry file that kick starts the server

- cors.dart: The cors header, add this into your responses like in the existing routes

- controllers: folder for holding routers, HomeController has the main router and you can following the patter display by TestController to mount additonal routers.

## Deployment to Heroku using Heroku CLI

- create a git repo and commit your project
    - `git init`
    - `git add .`
    - `git commit -m "first commit"`

- `heroku create projectName`

- `heroku config:set DART_SDK_URL=https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.1/sdk/dartsdk-linux-x64-release.zip`

- `heroku config:add BUILDPACK_URL=https://github.com/igrigorik/heroku-buildpack-dart.git`

- `heroku config:set DART_BUILD_CMD="./dart-sdk/bin/dart compile exe web/server.dart"`

- `git push heroku master`

- API Deployed!!

#### Heroku Database Setup

#### Setting Up The Database

- head to the heroku dashboard for your project

- go to the resources tab

- provision a free heroku postgres database

- go the database dashboard, under settings you'll find the database credentials

- use those credentials to add the following heroku config vars

```
DB_HOST
DB_PORT
DB_DATABASE
DB_USERNAME
DB_PASSWORD
```

- you'll see a command like this that will let us access the psql shell for the database so we can create our table. `heroku pg:psql postgresql-objective-XXXX --app projectname`

- create your tables

- in connection.dart add useSSL in the list of arguments `this.conn = PostgreSQLConnection(host, port, database, username: username, password: password, useSSL: true);` and push your code again your api will be deployed!


## DATABASE CONNECTION

Environment Variables for Database Settings

- DB_HOST
- DB_PORT
- DB_DATABASE
- DB_USERNAME
- DB_PASSWORD

These can be changed in connection.dart

the test.dart file in connection folder is a good tool for testing out database queries and your models

## Models

A Sample model is in the models folder that you can copy to create your own by modifying their methods as needed.

follow the patterns in initiateModel and the /getall route in testController to see how to use your model in your routes.

## Migrations

I'm using the raw postgres drivers, so no migrations. So you'll need to create the database and tables for your models to work.

