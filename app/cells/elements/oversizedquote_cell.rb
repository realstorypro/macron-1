# frozen_string_literal: true

module Elements
  class OversizedquoteCell < HeaderCell
    def summary_alignment
      "centered"
    end
    def summary_extra_classes
      "larger uppercased"
    end
  end
end
