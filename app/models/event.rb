class Event < ApplicationRecord

    validates_presence_of :name, :friendly_id
    before_validation :generate_friendly_id, :on => :create
    validates_uniqueness_of :friendly_id
    validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/
    STATUS = ["draft", "public", "private"]
    validates_inclusion_of :status, :in => STATUS

    mount_uploader :logo, EventLogoUploader
    mount_uploaders :images, EventImageUploader
    serialize :images, JSON

  def to_param
     self.friendly_id
   end

    belongs_to :category, :optional => true
    has_many :tickets, :dependent => :destroy, :inverse_of  => :event
    accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank

    has_many :attachments, :class_name => "EventAttachment", :dependent => :destroy
    accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => :all_blank

    has_many :registrations, :dependent => :destroy

    has_many :registration_imports, :dependent => :destroy



   include RankedModel
   ranks :row_order

   scope :only_public, -> { where( :status => "public" ) }
   scope :only_available, -> { where( :status => ["public", "private"] ) }


   protected

   def generate_friendly_id
     self.friendly_id ||= SecureRandom.uuid
   end


end
