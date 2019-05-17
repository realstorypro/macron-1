# frozen_string_literal: true

# TODO: see if there's a better way to patch the merit getm
module Merit
  class Score < ActiveRecord::Base
    self.table_name = :merit_scores
    belongs_to :sash
    has_many :score_points,
             dependent: :destroy,
             class_name: 'Merit::Score::Point'

    def points
      score_points.group(:score_id).sum(:num_points).values.first || 0
    end

    class Point < ActiveRecord::Base
      belongs_to :score, class_name: 'Merit::Score'
      has_one :sash, through: :score
      has_many :activity_logs,
               class_name: 'Merit::ActivityLog',
               as: :related_change
      delegate :sash_id, to: :score
      after_create :broadcast_activity

      def broadcast_activity
        user = User.where(sash: self.score.sash).last
        ActionCable.server.broadcast("player_#{user.id}", user_id: user.id)
      end
    end
  end
end
