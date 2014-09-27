class Email::PersistenceForm < Reform::Form

  include Reform::Deletable

  property :address

  validates :address, presence: true


end