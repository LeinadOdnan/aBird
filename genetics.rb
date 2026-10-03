#use_bpm 107

#Vars for funtions
bassPossibilities = [[1],[1.5],[0.5,1],[0.5,1.5],[0.5,0.5,1],[0.5,0.5,1.5]]
use_random_seed Time.now.to_i #Always different pattern

#Funtions
# Bass Pattern Generator
define :randomPattern do
    adder = (3..8).to_a.choose
    
    while true
      pattern = []
      
      adder.times do
        pattern += bassPossibilities.choose
      end
    
      total = (pattern.sum * 2).to_i
    
      if total % 8 == 0 && total <= 24
        return pattern
      end
    end
end
  
  
#Kick Pattern Generator
define :kickBeats do |hits, beats|
    grid = (0...(beats*2)).map{|i| i*0.5}
    hits = [hits, 1].max
    introGridKick = grid.shuffle.take(hits).sort
    
    sleeps = []
    last = 0
    
    introGridKick.each do |p|
      sleeps.push(p - last)
      last = p
    end
    
    sleeps.push(beats - last)
    
    return sleeps
end