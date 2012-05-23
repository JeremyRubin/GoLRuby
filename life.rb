class Game    
    def initialize(xSize, ySize)
        @x = xSize.to_i
        @y = ySize.to_i
        @dish = Array.new(@x, 0)
        
        0.upto(@x-1) {|i| 
               @dish[i] = Array.new(@y, 0)
            0.upto(@y-1){ |j| @dish[i][j] = 1 if rand > 0.5}}
    end
    
    def printOut
        0.upto(@x-1) {|i|
            s = ''
            0.upto(@y-1){ |j| s +=  ' '+ @dish[i][j].to_s}
            puts s.gsub(/0/, " ").gsub(/1/, "0")

        }
                    @x.times {print"_"}
        puts ""
    end
    
    def generation
        printOut
        dishCopy = Marshal.load(Marshal.dump(@dish))
        change = Marshal.load(Marshal.dump(@dish))
        neighbors = [[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]
        
        0.upto(@x-1) {|i|
            0.upto(@y-1){|j|
                sum = 0
                neighbors.each do |x|
                         sum += dishCopy[i+x[0]][j+x[1]] unless dishCopy[i+x[0]] == nil or dishCopy[i+x[0]][j+x[1]] == nil
                end
                change[i][j] = 0 if (sum >=4 or sum <= 2)
                change[i][j] = dishCopy[i][j] if (sum == 2)
                change[i][j] = 1 if (sum == 3)
            }
        }
        
        
        @dish = Marshal.load(Marshal.dump(change))
    end
end


newGame = Game.new(100, 50)
100.times {newGame.generation}
#fsdfs