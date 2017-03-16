require 'fileutils'

class LineFileCreator
  def initialize(filename)
    @filename = filename
  end

  def create_line_files
    return unless original_file_exist?
    make_empty_directory
    File.foreach("#{Line::INITIAL_LINES_FILE_PATH}/#{filename}").with_index do |text, index| 
      create_single_line_file(text, index)
    end
    
    delete_original_file
  end

  private

  attr_reader :filename

  def clear_folder
    FileUtils.rm_rf("#{Line::LINES_PATH}/.", secure: true)
  end

  def create_single_line_file(text, index)
    single_line_file = File.new("#{Line::LINES_PATH}/#{index+1}.rb", 'w+') 
    single_line_file.write(text.gsub(/\n/,""))
    single_line_file.close
  end

  def create_folder
    FileUtils.mkdir_p(Line::LINES_PATH)
  end

  def delete_original_file
    FileUtils.rm_rf("#{Line::INITIAL_LINES_FILE_PATH}/#{filename}", secure: true)
  end

  def directory_exist?
    File.directory?(Line::LINES_PATH)
  end

  def make_empty_directory
    if directory_exist?
      clear_folder      
    else
      create_folder
    end
  end

  def original_file_exist?
    File.exist?("#{Line::INITIAL_LINES_FILE_PATH}/#{filename}")
  end
end