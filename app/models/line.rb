require 'pstore'

class Line
  INITIAL_LINES_FILE_PATH = 'lib/assets/text_files'
  LINES_PATH = "../text_files/lines"

  def initialize(id)
    @id = id
  end

  def exist?
    cache_exist? || file_exist?
  end

  def text
    @text ||= if cache_exist?
      cached_text
    elsif file_exist?
      retrieve_line
    else
      false
    end
  end

  private

  attr_reader :id

  def cache_exist?
    cached_ids.transaction(true) do 
      cached_ids[id].present?
    end
  end

  def cached_ids
    @cached_ids ||= PStore.new('lines.pstore')
  end

  def cached_text
    cached_ids.transaction(true) do 
      cached_ids[id]
    end    
  end

  def file_exist?
    File.file?(file_path)
  end

  def file_path
    "#{LINES_PATH}/#{id}.rb"
  end

  def retrieve_line
    file = File.open(file_path)
    text = file.read
    file.close
    store_line(text)
  end

  def store_line(text)
    cached_ids.transaction do 
      cached_ids[id] = text
    end
  end
end