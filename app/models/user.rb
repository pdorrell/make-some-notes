class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  
  has_many :notes
  
  after_create :set_latest_terms_version
  
  def after_database_authentication
    set_latest_terms_version
  end

  def set_latest_terms_version
    current_terms = UserAgreement.get_current
    if current_terms && current_terms.version != latest_terms_version
      puts "Setting latest terms version for user #{email} to #{current_terms.version}"
      self.latest_terms_version = current_terms.version
      save
    end
  end
  
  def has_accepted_latest_terms?
    latest_terms_version == accepted_terms_version
  end
  
  def accept_terms_and_conditions(user_agreement)
    self.accepted_terms_version = user_agreement.version
    save
  end

end
