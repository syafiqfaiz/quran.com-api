# == Schema Information
#
# Table name: verses
#
#  id            :integer          not null, primary key
#  chapter_id    :integer
#  verse_number  :integer
#  verse_index   :integer
#  verse_key     :string
#  text_madani   :text
#  text_indopak  :text
#  text_simple   :text
#  juz_number    :integer
#  hizb_number   :integer
#  rub_number    :integer
#  sajdah        :string
#  sajdah_number :integer
#  page_number   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class V3::VerseSerializer < V3::ApplicationSerializer
  attributes :id, :verse_number, :chapter_id, :verse_key, :text_madani, :text_indopak, :text_simple, :juz_number, :hizb_number, :rub_number, :sajdah, :sajdah_number, :page_number
  has_one :audio, if: :render_audio?, serializer: V3::AudioFileSerializer

  has_many :translations, if: :render_translations? do
    object.translations.includes(:resource_content).where(resource_content_id: scope[:translations])
  end

  has_many :media_contents, if: :render_media? do
    object.media_contents.includes(:resource_content).where(resource_content_id: scope[:media])
  end

  has_many :words

  def render_audio?
    scope[:recitation].present?
  end

  def render_translations?
    scope[:translations].present?
  end

  def render_media?
    scope[:media].present?
  end

  def audio
    object.audio_files.find_by(recitation_id: scope[:recitation])
  end
end
