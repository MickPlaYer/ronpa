class Sentence < ApplicationRecord
  validates_presence_of :content, :tag
  enum tag: [ :sentence, :noise ]
end
