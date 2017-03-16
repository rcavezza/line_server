require 'fileutils'

namespace :file_data_tasks do
  desc "Create individual line files based on a smaller textfile"

  task :create_line_files, [:filename] =>  [:environment] do |t, args|
    args.with_defaults(:filename => 'file_small.txt')
    filename = args[:filename]

    LineFileCreator.new(filename).create_line_files
  end
end
