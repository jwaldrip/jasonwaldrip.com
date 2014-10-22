require 'yaml'

module JobHelper

  def render_jobs
    Dir['data/resume/jobs/*.yml']
    .map { |f| load_job f }
    .sort_by { |p| p[:end_date] }
    .reverse
    .select { |p| p[:start_date] < Date.today }
    .map { |p| render 'resume/position', p }
    .join("\n")
  end

  def load_job(file)
    YAML.load_file(file).symbolize_keys.tap do |locals|
      [:start_date, :end_date].each do |f|
        locals[f] = Chronic.parse(locals[f]) if locals[f].present?
      end
      locals[:accomplishments] ||= []
    end
  end

end
