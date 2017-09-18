class Operation < ApplicationRecord
include ApplicationHelper

    before_save :calculate_cycle_time

    
    belongs_to :machine
    belongs_to :element

private
    def calculate_cycle_time
        self.cycle_time = 8.0*3600.0/self.efficiency_per_shift
    end

end
