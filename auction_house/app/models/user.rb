class User < ActiveRecord::Base
    has_secure_password
    has_many :bids
    has_many :auctions, through: :bids 
    validates :username, :email, uniqueness: true
  

def slug 
    @slug = slugify(self.username)
end

def slugify(name)
    split_apostrophes = name.split(/[']/)
    slugged_name = split_apostrophes.join
    name_array = slugged_name.downcase.split(/[\W]/)
    name_spaces = name_array.delete_if{|x| x ==""}
    slugified = name_spaces.join("-")
  end
  
  def self.find_by_slug(slug)
    self.all.detect{|x| x.slug == slug}
  end

end
