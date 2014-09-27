module Reform::Deletable
  
  extend ActiveSupport::Concern

  included  do
    property :id, virtual: true
    property :_destroy, virtual: true
  end

  def marked_for_destruction?
    _destroy != "false"
  end 

  def not_persisted?
    id.blank?
  end

  def destroy
    model.destroy
  end

end