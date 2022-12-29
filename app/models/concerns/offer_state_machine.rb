module OfferStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :state do
        state :created, initial: true
        state :published
        state :waiting
        state :processing
        state :processed
        state :closed
    
        event :publish do
          transitions from: %i[created waiting], to: :published
        end
    
        event :wait do
          transitions from: [:published, :waiting, :created], to: :waiting
        end
    
        event :process do
          transitions from: :published, to: :processing
        end
    
        event :complete_process do
          transitions from: :processing, to: :processed
        end
    
        event :close do
          transitions from: %i[published waiting], to: :closed
        end
      end
  end
end
