def calculate_monthly_payment(amount, rate, total_months)
  monthly_rate = rate / 12
  amount * (monthly_rate / (1 - (1 + monthly_rate) ** -total_months))
end

def calculate_interest(rate, duration, amount) # ex 1
  total_months = duration * 12

  p = calculate_monthly_payment(amount, rate, total_months)
  p * total_months - amount
end

def calculate_optimal_ratio(rate1, duration1, rate2, duration2) # ex 2
  optimal_ratio = 0

  (0.01...100).step(0.01).each do |portion1|
    portion1 = portion1.round(2)
    portion2 = (100 - portion1).round(2)
    m1 = calculate_monthly_payment(portion1, rate1, duration1 * 12)
    monthly_interest2 = portion2 * rate2 / 12
    m2 = calculate_monthly_payment(portion2, rate2, (duration2 - duration1) * 12)
    if (m1 + monthly_interest2).round(2) == m2.round(2)
      optimal_ratio = portion1
    end
  end
  optimal_ratio
end

def get_minimum_interest_combination(total_duration, rate_grid) # ex 3
  grid = rate_grid.sort.to_h
  combination = {
    duration: 0,
    rate: 0,
    ratio: 0,
    interest: calculate_interest(grid[total_duration], total_duration, 100)
  }

  grid.each do |duration, rate|
    break if duration >= total_duration

    portion1 = calculate_optimal_ratio(rate, duration, grid[total_duration], total_duration)
    next if portion1 == 0
    portion2 = (100 - portion1).round(2)

    interest_first = calculate_interest(rate, duration, portion1)
    interest_second_during_first = grid[total_duration] * duration * (portion2)
    interest_second_after_first = calculate_interest(grid[total_duration], total_duration - duration, portion2)

    interest = (interest_first + interest_second_during_first + interest_second_after_first).round(2)

    if interest <= combination[:interest]
      combination[:duration] = duration
      combination[:rate] = rate
      combination[:ratio] = portion1
      combination[:interest] = interest
    end
  end

  combination
end