# frozen_string_literal: true

# rubocop:disable GlobalVars

#$redis = Redis::Namespace.new("aquarius", redis: Redis.new)
#$site_setting_interface = SiteSettingInterface.new($redis, "site_settings")
$site_setting_interface = SiteSettingInterface.instance

# rubocop:enable GlobalVars
