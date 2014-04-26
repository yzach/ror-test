# -*- encoding: utf-8 -*-

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create({email: 'yossi.zach@gmail.com', password: '12345678', password_confirmation: '12345678'})

Language.create({code: 'en', name: 'English'})
Language.create({code: 'ru', name: 'Русский'})
Language.create({code: 'he', name: 'עברית'})

story = Story.create({user: user})
StoryTranslation.create({story: story, auto_translated: false, language_id: 2, title: 'Виды фазовых снов', text: 'Все из вас видят сны. И это нормально. Сколько раз проснувшись вы ни как не могли поверить что это был сон, он же был такой настоящий? Сколько раз вы думали что сделали/видели что нибудь, а на самом деле этого никогда не было? А сколько раз вы хотели посмотреть сон, где можно встретить потерянных людей? Как бы было удобно если во сне кто-то подсказал как сделать/починить/исправить какую нибудь вещь, проект, машину в конце концов?'})
