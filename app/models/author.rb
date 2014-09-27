class Author < ActiveRecord::Base

  has_many :emails

  belongs_to :article

  # isn't it a bug in reform?
  accepts_nested_attributes_for :emails

end
