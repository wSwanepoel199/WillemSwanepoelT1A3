# Imports installed gems
require "tty-prompt"
prompt = TTY::Prompt.new
require "tty-file"
file = TTY::File
require "tty-box"
box = TTY::Box.frame(padding: 3, align: :center)
box_example= TTY::Box.frame "Drawing a box in", "terminal emulator", padding: 3, align: :center
require "tty-command"
$cmd = TTY::Command.new(printer: :quiet)
require 'io/console'  

def continue
  print "press any key"
  STDIN.getch
  $cmd.run("clear")
end

class Float
  def round_down(n=0)
    int,dec=self.to_s.split('.')
    "#{int}.#{dec[0...n]}".to_f
  end
end
class DPR
  def initialize
    # attack bonus
    @A=0
    # target AC
    @M=0
    # type of dice, defaul d4
    @D=0
    # number of dice
    @N=0
    # Any bonuses to attack
    @B=0
    # The lowest number needed to crit
    @C=0
  end
  def crit(crit)
    # The lowest number needed to crit
    @C=crit
    # chance to crit
    @P=0.0
    # number range
    @R=(0..20).to_a
    @R[0] = nil
    @R.each do |n|
      next unless n
      break if n > @C
      if n < @C
        @R[n] = nil
      end
    end
    @R= @R.compact
    @R= @R.length()
    @P= @R/20.0
    p @P
  end
  def hit(dc, attack)
    # chance of succeding the attack/save
    @H = 0.0
    # attack bonus
    @A=0
    # target AC
    @M=0
    # assign input values to attack bonus and target ac
    @M=dc
    @A=attack
    # calculate chance to hit
    @H =1.0-((@M-@A)/20.0)
    puts " hit chance#{@H.round(2)}" 
  end
  def hit_adv(dc, attack)
    # chance of succeding the attack/save
    @H = 0.0
    # attack bonus
    @A=0
    # target AC
    @M=0
    # assign input values to attack bonus and target ac
    @M=dc
    @A=attack
    # calculate chance to hit
    @H = 1.0-((@M - @A)/20.0)**2
    puts " hit chance with advantage#{@H.round(2)}" 
  end
  def hit_dis(dc, attack)
    # chance of succeding the attack/save
    @H = 0.0
    # attack bonus
    @A=0
    # target AC
    @M=0
    # assign input values to attack bonus and target ac
    @M=dc
    @A=attack
    # calculate chance to hit
    @H = ((20 - @M + @A)/20.0)**2
    puts " hit chance with disadvantage#{@H.round(2)}" 
  end
end


print TTY::Box.frame "Hello! and welcome to Will Swan's \nDungeons And Dragons (D&D), Damage Per Round (DPR), Calculator.\nThis calculator assumes you have an existing D&D character.\nIf you do not please go make one before returning.", padding: 3, align: :center
continue


binanry = prompt.yes?("Is this the first time using this calculator?")

if binanry == true
  $cmd.run("clear")
  print TTY::Box.frame "Brilliant, lets generate you a character profile right away. \nFor the following steps please refer to your D&D character who's \nDPR you would like to calculate. \n",  padding: 3, align: :center

  dpr = DPR.new
  dpr.hit(16, 5) 
  dpr.hit_adv(16, 5)
  dpr.hit_dis(16, 5)
  dpr.crit(20)  
  dpr.crit(18)
end