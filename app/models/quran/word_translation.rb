# == Schema Information
#
# Table name: word_translation
#
#  translation_id :integer          not null, primary key
#  word_id        :integer          not null
#  language_code  :text             not null
#  value          :text             not null
#

class Quran::WordTranslation < ActiveRecord::Base
    self.table_name = 'word_translation'

    belongs_to :word, class_name: 'Quran::Word'
    belongs_to :language, class_name: 'Locale::Language'
end
