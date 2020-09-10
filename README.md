# Scaffold for social media app with Ruby on Rails
![CI Status Badge](https://github.com/Bluette1/ror-social-scaffold/workflows/Linters/badge.svg)


## Built With

- Ruby v2.7.0
- Ruby on Rails v5.2.4

## Description
- The original project specifications can be found [here](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project).
- This project was about implementing the necessary friendship features of a typical modern day social media app.
  - Registered users of the app are able to send friendship requests to other users; users are able to accept friendship requests from other users.
  - A logged in user is only able to view their own posts as well as their friends' on their timeline page.
- This repo was forked from [microverseinc/ror-social-scaffold](https://github.com/microverseinc/ror-social-scaffold) which includes initial code for the social media app with basic styling.

## Live Demo

[Click here](https://post-bk-app.herokuapp.com/)


## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.6.3
Rails: 5.2.3
Postgres: >=9.5

### Setup

Instal gems with:

```
bundle install
```

Setup database with:

```
   rails db:create
   rails db:migrate
```



### Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

```
    rpsec --format documentation
```

### How to use the site
Make sure the server is running
- Go to http://localhost:3000/ in your web browser
- You will be able to access the following routes (among others)
   - http://localhost:3000/users
   - http://localhost:3000/users/:id
   - http://localhost:3000/posts
- Follow the links on the site to access the available features, including sign up and sign in functionality.

### Deployment
- You can deploy on [Heroku](https://devcenter.heroku.com/categories/ruby-support).

## Authors

👤 **Marylene Sawyer**
- Github: [@Bluette1](https://github.com/Bluette1)
- Twitter: [@MaryleneSawyer](https://twitter.com/MaryleneSawyer)
- Linkedin: [Marylene Sawyer](https://www.linkedin.com/in/marylene-sawyer)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments
- [Friendships in Active Record](https://smartfunnycool.com/friendships-in-activerecord/)
- [Using custom relation queries to establish Friends and Friendships in Rails and ActiveRecord](https://medium.com/@elizabethprendergast/using-custom-relation-queries-to-establish-friends-and-friendships-in-rails-and-activerecord-6c6e5825433a)
- [EXPLAIN EXTENDED: Selecting friends](https://stackoverflow.com/questions/4219979/sql-best-practice-for-a-friendship-table)



## 📝 License

This project is [MIT](https://opensource.org/licenses/MIT) licensed
