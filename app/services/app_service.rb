module AppService
    def contains_required_headers?(required_headers, csv_headers)
        required_headers.each do |required_header|
            if csv_headers.any? { |e| e == required_header }
                return true
            else
                return false
            end
        end
    end
end