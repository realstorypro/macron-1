# frozen_string_literal: true

# rubocop:disable GlobalVars

$redis = Redis::Namespace.new("aquarius", redis: Redis.new)

# rubocop:enable GlobalVars
