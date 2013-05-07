module ProfilesHelper
  def profile_time(microseconds)
    return unless microseconds
    microseconds = 0 if microseconds < 0
    number_to_human(microseconds / 1000.0,
                    format:      '%n%u',
                    precision:   2,
                    significant: false,
                    strip_insignificant_zeros: false,
                    units:       { unit: 'ms', thousand: 's' })
  end

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
              file_profile['total']
            else
              profile_line_wall_time(file_profile, index) || 0
            end
    total = total / 1000.0
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
    line_profile['wall_time']
  end

  def profile_line_cpu_time(file_profile, index)
    line_profile = file_profile['lines'][index.to_s]
    return unless line_called?(line_profile)
    line_profile['cpu_time']
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
