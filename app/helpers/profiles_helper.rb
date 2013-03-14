module ProfilesHelper
  def is_profile_line_important?(line_profile)
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
