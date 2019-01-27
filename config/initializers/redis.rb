# Deleting Site Settings on Restart
redis = Redis::Namespace.new("aquarius", redis: Redis.new)
namespace = "site_settings"

redis.del namespace
