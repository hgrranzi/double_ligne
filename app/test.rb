def calculate_interest(rate, duration, amount)
  monthly_rate = rate / 12.0
  total_months = duration * 12

  p = amount * (monthly_rate / (1 - (1 + monthly_rate) ** -total_months))
  p * total_months - amount
end

def calculate_optimal_ratio(rate1, duration1, rate2, duration2)
  0
end

def get_minimum_interest_combination(total_duration, rate_grid)
  combination = {
    duration: 0,
    rate: 0,
    ratio: 0,
    interest: calculate_interest(rate_grid[total_duration], total_duration, 100.0)
  }

  rate_grid.each do |duration, rate|
    break if duration >= total_duration

    ratio = calculate_optimal_ratio(duration, rate, total_duration, rate_grid[total_duration])

    interest_first = calculate_interest(rate, duration, ratio)
    interest_second_during_first = rate_grid[total_duration] * duration * (100.0 - ratio)
    interest_second_after_first = calculate_interest(rate_grid[total_duration], total_duration - duration, 100.0 - ratio)

    interest = interest_first + interest_second_during_first + interest_second_after_first

    if interest <= combination[:interest]
      combination[:duration] = duration
      combination[:rate] = rate
      combination[:ratio] = ratio
      combination[:interest] = interest
    end
  end

  combination
end

begin
  rate_grid = { 10 => 0.029,
                12 => 0.032,
                15 => 0.035,
                20 => 0.038,
                22 => 0.038,
                25 => 0.044 }.sort.to_h

  puts get_minimum_interest_combination(25, rate_grid)
end