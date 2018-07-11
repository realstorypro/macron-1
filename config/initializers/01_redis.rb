# frozen_string_literal: true

# rubocop:disable GlobalVars

$redis = Redis::Namespace.new("aquarius", redis: Redis.new)

# clearing things out old site settings
$redis.del "site_settings"

# rubocop:enable GlobalVars
