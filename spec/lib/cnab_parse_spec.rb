require 'rails_helper'

RSpec.describe CnabParser do
  describe 'file exists' do
    it 'should have a valid data structure for a valid file' do
      valid_file = File.join(Rails.root, 'spec', 'fixtures', 'valid_cnab_file.txt')
      cnab = CnabParser.new(valid_file)
      cnab.parse

      expect(cnab.content.size).to equal(21)
      expect(cnab.content[0][:transaction_type]).to eq(3)
      expect(cnab.content[0][:occurrence_date].strftime('%d/%m/%Y')).to eq('01/03/2019')
      expect(cnab.content[0][:occurrence_time].strftime('%H:%M:%S')).to eq('15:34:53')
      expect(cnab.content[0][:occurrence_value]).to eq(142.0)
      expect(cnab.content[0][:recipient_cpf]).to eq('09620676017')
      expect(cnab.content[0][:credit_card_number]).to eq('4753****3153')
      expect(cnab.content[0][:store_owner_name]).to eq('JOÃO MACEDO')
      expect(cnab.content[0][:store_name]).to eq('BAR DO JOÃO')
    end

    it 'should raise CustomErrors::InvaldCnabFileException for invalid transaction type' do
      invalid_transaction_type_cnab_file = File.join(Rails.root, 'spec', 'fixtures', 'invalid_transaction_type_cnab_file.txt')
      cnab = CnabParser.new(invalid_transaction_type_cnab_file)
      expect { cnab.parse }.to raise_error(CustomErrors::InvaldCnabFileException)
    end
  
    it 'should raise CustomErrors::InvaldCnabFileException for invalid date' do
      invalid_date_cnab_file = File.join(Rails.root, 'spec', 'fixtures', 'invalid_date_cnab_file.txt')
      cnab = CnabParser.new(invalid_date_cnab_file)
      expect { cnab.parse }.to raise_error(CustomErrors::InvaldCnabFileException)
    end
  
    it 'should raise CustomErrors::InvaldCnabFileException for invalid time' do
      invalid_time_cnab_file = File.join(Rails.root, 'spec', 'fixtures', 'invalid_time_cnab_file.txt')
      cnab = CnabParser.new(invalid_time_cnab_file)
      expect { cnab.parse }.to raise_error(CustomErrors::InvaldCnabFileException)
    end
  
    it 'should raise CustomErrors::InvaldCnabFileException for invalid value' do
      invalid_value_cnab_file = File.join(Rails.root, 'spec', 'fixtures', 'invalid_value_cnab_file.txt')
      cnab = CnabParser.new(invalid_value_cnab_file)
      expect { cnab.parse }.to raise_error(CustomErrors::InvaldCnabFileException)
    end
  end

  describe 'file does not exist' do
    it 'should raise CustomErrors::FileNotFoundException' do
      file_does_not_exist = File.join(Rails.root, 'spec', 'fixtures', 'cnab_file_does_not_exist.txt')
      expect { CnabParser.new(file_does_not_exist) }.to raise_error(CustomErrors::FileNotFoundException)
    end
  end

end