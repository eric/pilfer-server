module ProfilesHelper
  def file_profile_class(file_profile)
    if file_profile['total'] > @minimum * 100
      'error'
    elsif file_profile['total'] > @minimum
      'warning'
    end
  end

  def line_called?(line_profile)
    line_profile && line_profile['calls'] && line_profile['calls'] > 0
  end

  def profile_line_wall_time(line_source, line_profile)
    return unless line_called?(line_profile)

    wall_time = (line_profile['wall_time'] / 1000.0).round(2)
    "#{number_with_delimiter(wall_time)}ms"
  end

  def profile_line_cpu_time(line_source, line_profile)
    return unless line_called?(line_profile)

    cpu_time = (line_profile['cpu_time'] / 1000.0).round(2)
    "#{number_with_delimiter(cpu_time)}ms"
  end

  def profile_line_calls(line_source, line_profile)
    return unless line_called?(line_profile)

    number_with_delimiter(line_profile['calls'])
  end

  def output_profile_line(line_source, line_profile)
    if line_profile && line_profile['calls'] && line_profile['calls'] > 0
      if @mode == 'cpu'
        idle = line_profile['wall_time'] - line_profile['cpu_time']
        cpu  = line_profile['wall_time']

        idle = 0 if idle < 0

        sprintf("% 8.1fms + % 8.1fms (% 5d) | %s", cpu/1000.0, idle/1000.0, line_profile['calls'], h(line_source))
      else
        total = line_profile['wall_time']

        sprintf("% 8.1fms (% 5d) | %s", total/1000.0, line_profile['calls'], h(line_source))
      end
    else
      if @mode == 'cpu'
        sprintf("                                | %s", h(line_source))
      else
        sprintf("                   | %s", h(line_source))
      end
    end
  end
end
