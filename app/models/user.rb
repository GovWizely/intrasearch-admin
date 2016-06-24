class User < ActiveResource::Base
  extend Devise::Models
  include ActiveModel::Conversion

  self.site = URI.join(Intrasearch.configuration.host_url, '/admin/').to_s

  schema do
    attribute 'email', :string
    attribute 'encrypted_password', :string
    attribute 'reset_password_token', :string
    attribute 'reset_password_sent_at', :datetime

    attribute 'remember_created_at', :datetime

    attribute 'sign_in_count', :integer
    attribute 'current_sign_in_at', :datetime
    attribute 'last_sign_in_at', :datetime
    attribute 'current_sign_in_ip', :string
    attribute 'last_sign_in_ip', :string

    attribute 'failed_attempts', :integer
    attribute 'unlock_token', :string
    attribute 'locked_at', :datetime
  end

  devise :lockable,
         :database_authenticatable,
         :recoverable,
         :trackable

  validates_presence_of :email
  after_create :send_reset_password_instructions

  def as_json(options = {})
    super options.reverse_merge(only: self.known_attributes)
  end

  def [](attr_name)
    self.send attr_name
  end

  def []=(attr_name, value)
    self.send "#{attr_name}=", value
  end

  protected

  def update
    run_callbacks :update do
      connection.patch(element_path(prefix_options), encode(only: self.known_attributes), self.class.headers).tap do |response|
        load_attributes_from_response(response)
      end
    end
  end
end
