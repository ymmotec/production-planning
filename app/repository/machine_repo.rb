module Repo
    class MachineRepo
        def get_machine(id:)
            machine = Machine.find(id).first
        end

        def get_operations_for_machine(id:)
            machine = get_machine(id: id)
            operations = Operation.where(machine: machine).all
        end


    end
    
end