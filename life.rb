class Game    
    def initialize
        puts "How large is the playing field? (input 179X49 for example)"
        xSize, ySize = gets.split(/X/i) # case insensitive RegEx  to split input
        xSize, ySize = 179, 49 if xSize || ySize == ''
        puts "What percent of cells do you want filled?"
        @sparsity = gets.to_f/100 # takes a percent input and converts to decimal
        @x = xSize.to_i
        @y = ySize.to_i
        @dish = Array.new(@x, 0) # 'spawn' an array with the right X dimension
        (0...@x).each do |i| # fills the array with arrays to create a 2-d array
            @dish[i] = Array.new(@y, 0)
            (0...@y).each do |j|
                @dish[i][j] = 1 if rand < @sparsity # randomness, but a defined fill percentage
            end
        end
        printOut # print the newly made array
    end
    def printOut # this function prints the arrays contents into terminal in a pretty manner
        (0...@y).each do |y|
            row = ''
            (0...@x).each do |x|
                row += @dish[x][y].to_s
            end
            puts '|'+row.gsub(/0/, " ").gsub(/1/, "0")+'|' # makes cells into 0's and blanks into whitespace with borders
        end
        @x.times {print"_"} 
        puts ""
    end
    def generate(generations)# finds the next frame and prints current to terminal
        (0..generations).each do |generation|
            change = Marshal.load(Marshal.dump(@dish))# this takes the contents and completely extracts them, then loads them into a new object which we can edit worry free
            neighbors = [[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0]] # the eight cells around a point to check for life
            (0...@y).each do |y|
                (0...@x).each do |x|# go to each cell
                    sum = 0
                    neighbors.each do |n|# check the neighbors
                        sum += @dish[x+n[0]][y+n[1]] unless @dish[x+n[0]] == nil or @dish[x+n[0]][y+n[1]] == nil # careful around the edges, and sum the surroundings
                    end
                    change[x][y] = 0 if (sum >=4 or sum <= 2) # cells with 4 neighbors or more, or 2 or less are dead
                    change[x][y] = @dish[x][y] if (sum == 2) #but if it is exactly 2, and it was already alive, it lives
                    change[x][y] = 1 if (sum == 3) # 3 is always alive
                end
            end
            @dish = Marshal.load(Marshal.dump(change)) #commit our changes
            printOut# print new frame to terminal
        end
    end
end

newGame = Game.new
newGame.generate(100)
#fsdfs