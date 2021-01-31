class CnabParser
  attr_accessor :file_path, :content
  
  def initialize(file_path)
    self.content = []
    if File.exists?(file_path)
      self.file_path = file_path
    else
      self.file_path = nil
      raise CustomErrors::FileNotFoundException.new("File not found")
    end
  end

  def parse
    i = 0
    begin
      File.read(self.file_path).split(/\n/).each do |line|
        i = i + 1
        next if line.strip == ''
        self.content.push(
          {
            transaction_type: extract_transaction_type(line),
            occurrence_date: extract_occurrence_date(line),
            occurrence_value: extract_occurrence_value(line),
            recipient_cpf: extract_recipient_cpf(line),
            credit_card_number: extract_credit_card_number(line),
            occurrence_time: extract_occurrence_time(line),
            store_owner_name: extract_store_owner(line),
            store_name: extract_store(line),
          }
        )
      end
    rescue Exception => e
      self.content = []
      raise CustomErrors::InvaldCnabFileException.new("#{e.to_s} at line #{i.to_s}")
    end
  end

  private
  def extract_transaction_type(line)
    transaction_type = line[0, 1].strip
    raise Exception.new('Transaction type is invalid') if transaction_type.match(/^\d{1}$/).nil?

    return transaction_type.to_i
  end

  def extract_occurrence_date(line)
    occurrence_date_date = line[1, 8].strip
    raise Exception.new('Transaction type is invalid') if occurrence_date_date.match(/^\d{8}$/).nil?

    year = occurrence_date_date[0, 4].to_i    
    month = occurrence_date_date[4, 2].to_i    
    day = occurrence_date_date[6, 2].to_i    
    Exception.new('Date month is invalid') if month > 12 || month == 0
    Exception.new("Date day can't be 0") if day == 0
    Exception.new("Date day can't be greater than 31 for month #{month.to_s}") if [1, 3, 5, 7, 8, 10, 12].include?(month) && day > 31
    Exception.new("Date day can't be greater than 30 for month #{month.to_s}") if [4, 6, 9, 11].include?(month) && day > 30
    Exception.new("Date day can't be greater than 29 for month #{month.to_s} and year #{year.to_s}") if (month == 2) && (year % 4 == 0) && day > 29
    Exception.new("Date day can't be greater than 28 for month #{month.to_s} and year #{year.to_s}") if (month == 2) && (year % 4 != 0) && day > 28

    Date.parse(occurrence_date_date, "%Y%m%d")
  end

  def extract_occurrence_value(line)
    occurrence_value = line[9, 10].strip
    raise Exception.new('Value is invalid') if occurrence_value.match(/^\d{10}$/).nil?

    occurrence_value.to_f / 100.0
  end

  def extract_recipient_cpf(line)
    recipient_cpf = line[19, 11].strip
    raise Exception.new('CPF is invalid') if recipient_cpf.match(/^\d{11}$/).nil?

    recipient_cpf
  end

  def extract_credit_card_number(line)
    line[30, 12].strip
  end

  def extract_occurrence_time(line)
    occurrence_time = line[42, 6]
    raise Exception.new('CPF is invalid') if occurrence_time.match(/^\d{6}$/).nil?

    hour = occurrence_time[0,2].to_i
    minute = occurrence_time[2, 2].to_i
    second = occurrence_time[4, 2].to_i
    Exception.new('Time hour is invalid') if hour > 23
    Exception.new('Time minute is invalid') if minute > 59
    Exception.new('Time second is invalid') if second > 59

    Time.strptime("#{occurrence_time.strip}+0300", "%H%M%S%z")
  end

  def extract_store_owner(line)
    line[48, 14].strip
  end

  def extract_store(line)
    line[62, 19].strip
  end

end