# -*- encoding: utf-8 -*-

class CreateStoryTranslations < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :code
      t.string :name

      t.timestamps
    end

    create_table :story_translations do |t|
      t.integer :story_id
      t.string :title
      t.text :text
      t.integer :language_id
      t.boolean :auto_translated

      t.timestamps
    end

    add_index :story_translations, :story_id
    add_index :story_translations, :language_id
    add_index :story_translations, :auto_translated

    reversible do |dir|
      dir.up do
        # It's not the best place to preseed the db,
        # but app requires at least one language to be defined
        Language.find_or_create_by({code: 'en', name: 'English'})
        Language.find_or_create_by({code: 'ru', name: 'Русский'})
        Language.find_or_create_by({code: 'he', name: 'עברית'})
      end
    end

    reversible do |dir|
      dir.up do
        Story.all.each do |story|
          detected_language = translator.detect [story.title, story.text]
          language = Language.find_or_create_by code: detected_language

          story.translations.create(title: story.title, text: story.text,
                                    language: language, auto_translated: false)
        end
      end

      dir.down do
        Story.all.each do |story|
          translation = story.default_translation
          if translation
            story.update_attributes title: translation.title, text: translation.text
          end
        end
      end
    end
  end

  def translator
    Rails.configuration.translator
  end
end
