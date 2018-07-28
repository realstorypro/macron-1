module SiteSettings::Theme
  class Global < Setting

    before_create do
      errors.add(:base, "already one setting object existing") && (return false) if Global.exists?
    end

    def self.instance
      Global.first_or_create! do |settings|
      end
    end
  end
end
