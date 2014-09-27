# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


article = Article.create(name: "Some name")

author_1 = Author.create(name: "Author 1", article: article)
author_2 = Author.create(name: "Author 2", article: article)

Email.create(address: "email@example.com", author: author_1)
Email.create(address: "email2@example.com", author: author_1)

Email.create(address: "email3@example.com", author: author_2)
Email.create(address: "email4@example.com", author: author_2)
Email.create(address: "email5@example.com", author: author_2)
Email.create(address: "email6@example.com", author: author_2)