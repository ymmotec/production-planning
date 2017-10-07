class CSVImportFileService
    attr_reader :contains_required_headers, :error_message


    def initialize(required_headers, csv_headers)
        @required_headers = required_headers
        @csv_headers = csv_headers
        contains_required_headers?
    end

    private
    def contains_required_headers?
        # @contains_required_headers? = false
        @required_headers.each do |required_header|
            if @csv_headers.any? { |e| e == required_header }
                @error_message = nil
                @contains_required_headers = true
            else
                @error_message = "Plik nie zawiera wymaganych nagłówków."
                @contains_required_headers = false
            end
        end
        return @contains_required_headers
    end
end