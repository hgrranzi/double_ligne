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
    interest = calculate_interest(rate, duration, ratio) +
      calculate_interest(rate_grid[total_duration], total_duration - duration, 100 - ratio)

    if interest < combination[:interest]
      combination[:duration] = duration
      combination[:rate] = rate
      combination[:ratio] = ratio
      combination[:interest] = interest
    end
  end

  combination
end

begin
  rate_grid = { 10 => 2.9,
                12 => 3.2,
                15 => 3.5,
                20 => 3.8,
                22 => 3.8,
                25 => 4.4 }.sort.to_h

  puts get_minimum_interest_combination 25, rate_grid
  puts rate_grid
end