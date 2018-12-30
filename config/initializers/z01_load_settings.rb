$site_setting_interface = SiteSettingInterface.new($redis, "site_settings")
$site_setting_interface.update
# $redis.set "site_settings", $site_setting_interface.fetch
