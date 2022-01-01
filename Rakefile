# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path "./lib"

require "rubocop/rake_task"

Rake::TaskManager.record_task_metadata = true
Rake.add_rakelib "lib/tasks"

desc "install EVERYTHING"
task :install do
  require "highline/import"

  Rake.application.in_namespace(:install) do |namespace|
    namespace.tasks.sort_by(&:name).each do |t|
      Rake::Task[t.name].invoke if HighLine.agree("#{t.comment.capitalize}? ")
    end
  end
end

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ["--display-cop-names"]
end
