class StoresController < ApplicationController
  def index
    @current_store = nil
    begin
      @current_store = Store.find params[:store_id]
    rescue
    end
  end

  def upload
    @error = nil
    temp_file_path = nil
    file_path = nil

    dir = File.join(Rails.root, "storage#{Rails.env == 'test' ? '-test' : ''}")
    FileUtils.mkdir_p(dir)

    begin
      temp_file_path = params['file'].tempfile.path
      file_path = File.join(dir, params['file'].original_filename)
      if !File.exists?(file_path)
        FileUtils.cp(temp_file_path, file_path)
        begin
          cnab = CnabParser.new(file_path)
          CnabImportJob.perform_now(cnab)
        rescue Exception => e
          FileUtils.rm_f(file_path)
          @error = e.to_s
        end
      else
        @error = 'File already exists'
      end
    rescue Exception => e
      @error = 'Uploaded file is invalid'
    end
  end
end