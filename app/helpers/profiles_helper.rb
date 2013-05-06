module ProfilesHelper
  def profile_class(profile)
    time = profile.total_time / 1000.0
    if time > @minimum * 10
      'error'
    elsif time > @minimum
      'warning'
    end
  end

  def file_profile_class(file_profile, index = :none)
    total = if index == :none
              file_profile['total'] / 1000.0
            else
              profile_line_wall_time(file_profile, index) || 0
            end
    if total > @minimum * 100
      'error'
    elsif total > @minimum
      'warning'
    end
  end

  def line_called?(line_profile)
    line_profile && line_profile['calls'] && line_profile['calls'] > 0
  end

  def profile_line_wall_time(file_profile, index)
    line_profile = file_profile['lines'][index.to_s]
    return unless line_called?(line_profile)
    line_profile['wall_time'] / 1000.0
  end

  def profile_line_cpu_time(file_profile, index)
    line_profile = file_profile['lines'][index.to_s]
    return unless line_called?(line_profile)
    line_profile['cpu_time'] / 1000.0
  end

  def profile_line_idle_time(file_profile, index)
    line_profile = file_profile['lines'][index.to_s]
    return unless line_called?(line_profile)
    [ 0,
      profile_line_wall_time(file_profile, index) -
        profile_line_cpu_time(file_profile, index)
    ].max
  end

  def profile_line_calls(file_profile, index)
    line_profile = file_profile['lines'][index.to_s]
    return unless line_called?(line_profile)
    line_profile['calls']
  end
end
