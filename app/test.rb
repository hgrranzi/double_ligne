require_relative 'double_ligne'

grid1 = { 10 => 0.029,
          12 => 0.032,
          15 => 0.035,
          20 => 0.038,
          22 => 0.038,
          25 => 0.044 }

grid2 = { 20 => 0.037,
          25 => 0.037 }

loan = 10000
years = 25 # from one of the grids
grid = grid1

puts "Ex #1:"
res_1 = calculate_interest(grid[years], years, loan).round
puts "loan amount: #{loan} | " \
       "years: #{years} | " \
       "rate: #{grid[years]} | " \
       "interest: #{res_1}"

puts "Ex #3:"
res_2 = get_minimum_interest_combination(years, grid)
print "Optimal short line: "
if res_2[:ratio] == 0
  puts "No combination found"
else
  puts "years: #{res_2[:duration]} | " \
         "rate: #{res_2[:rate]} | " \
         "amount: #{(res_2[:ratio] * (loan / 100)).round} | " \
         "interest: #{(res_2[:interest] * (loan / 100)).round}"
end
