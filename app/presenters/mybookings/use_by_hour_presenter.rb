module Mybookings
  class UseByHourPresenter < BasePresenter
    def labels
      Array.new(24) { |hour| "#{hour}h" }
    end

    def series
      series = Array.new(1) { Array.new(24) { 0 } }
      model.each { |count| series.first[count[0].to_i] = count[1] }
      series
    end
  end
end
