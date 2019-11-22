Hypershield.schemas = {
    hypershield: {
        blacklist: w%(areas ar_internal_metadata),
        hide: %w(encrypted password token secret remember_created_at),
        show: %w(ahoy_visits.visit_token)
    }
}