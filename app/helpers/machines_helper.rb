module MachinesHelper
    def display_as_percent(value)
        result = value * 100
        return "#{result}%"
    end
end
