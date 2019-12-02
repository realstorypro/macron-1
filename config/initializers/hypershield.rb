Hypershield.schemas = {
    shield: {
        blacklist: %w(activities areas ar_internal_metadata blazer_audits
            blazer_checks blazer_dashboard_queries blazer_dashboards blazer_queries
            badges_sashes
            colors components
            elements
            merit_actions merit_activity_logs merit_score_points merit_scores
            follows likes mentions
            sashes settings
            profiles
            roles votes
            users_roles schema_migrations),
        hide: %w(encrypted password token secret ip
                current_sign_in_at current_sign_in_ip last_sign_in_ip remember_created_at updated_at users.slug
                phone_verified confirmed_at confirmation_sent_at unconfirmed_email sash_id
                level energy bypass2fa email_bidx phone_number_bidx email phone_number
                help advanced
                categories.description categories.created_at
                color_id
                payload
               ),
        show: %w(ahoy_visits.visit_token)
    }
}