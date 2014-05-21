require 'yaml'

module EducationHelper

  def render_schools
    Dir['data/resume/education/*.yml']
    .map { |f| load_school f }
    .sort_by { |p| p[:end_date] }
    .reverse
    .map { |p| render 'resume/school', p }
    .join("\n")
  end

  def load_school(file)
    YAML.load_file(file).symbolize_keys.tap do |locals|
      [:start_date, :end_date].each do |f|
        locals[f] = Chronic.parse(locals[f]) if locals[f].present?
      end
    end
  end

end