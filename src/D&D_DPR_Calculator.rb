# Imports installed gems
require "tty-prompt"
prompt = TTY::Prompt.new
require "tty-file"
file = TTY::File
require "tty-box"
box_example= TTY::Box.frame "Drawing a box in", "terminal emulator", padding: 3, align: :center
require "tty-command"
$cmd = TTY::Command.new(printer: :quiet)
require 'io/console' 

def continue
  print "press any key to continue"
  STDIN.getch
  $cmd.run("clear")
end
def box(message)
  box = TTY::Box.frame(padding: 3, align: :center) do
    "#{message}"
  end
  print box
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
    # Any bonuses to attack damage
    @B=0
    # The lowest number needed to crit
    @C=0
  end
  def dice(value, number)
    # type of dice, defaul d4
    @D=value
    # number of dice
    @N=number
    # number range
    @R=(1..@D).to_a
    # works out sum of array
    sum=@R.sum
    # calculates average value for dice
    dice=(sum.to_f/@R.length)*@N
  end
  def crit(crit)
    # The lowest number needed to crit
    @C=crit
    # chance to crit
    @CC=0.0
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
    @CC= @R/20.0
    @CC.round(2)
  end
  def crit_adv(crit)
    # class crit method and assings to @P variable
    @CC= crit(crit)
    # calculates how advantage affects crit chance
    @CA = 1-(1-@CC)**2
    @CA.round(2)
  end
  def crit_dis(crit)
    @CC= crit(crit)
    @CD= @CC**2
    @CD.round(2)
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
    @H.round(2) 
  end
  def hit_adv(dc, attack)
    # chance of succeding the attack/save
    @HA = 0.0
    # attack bonus
    @A=0
    # target AC
    @M=0
    # assign input values to attack bonus and target ac
    @M=dc
    @A=attack
    # calculate chance to hit
    @HA = 1.0-((@M - @A)/20.0)**2
    @HA.round(2) 
  end
  def hit_dis(dc, attack)
    # chance of succeding the attack/save
    @HD = 0.0
    # attack bonus
    @A=0
    # target AC
    @M=0
    # assign input values to attack bonus and target ac
    @M=dc
    @A=attack
    # calculate chance to hit
    @HD = ((20 - @M + @A)/20.0)**2
    @HD.round(2) 
  end
  def dpa(hit, damage, bonus, crit)
    # Chance to hit
    hit_chance=hit
    # average damage from dice
    damage_dice=damage
    # bonus to damage from set stats
    bonus_damage=bonus
    # chance to grit
    crit_chance=crit
    # the damage of the attack
    damage_per_attack=(crit_chance * damage_dice) + (hit_chance * (damage_dice + bonus_damage))
    damage_per_attack.round(2)
  end
end
dpr = DPR.new

box("Hello! and welcome to Will Swan's; 
Dungeons And Dragons (D&D), Damage Per Round (DPR), Calculator.
This calculator assumes you have an existing D&D character.
If you do not please go make one before returning.")
continue

type = prompt.select(box("Lets start with the basics. Are you; "),["Making attack rolls", "Casting a Spell with a saving throw"])
if type == "Making attack rolls"
  number_of_attacks = prompt.ask(box("How many attacks do you make per round?
    Include any Attacks of Opertunity and Bonus Action attacks in this number."), default: 1, convert: :int)
  attacks=(1..number_of_attacks).to_a
  attacks.each do |a|
    adv = prompt.select(box("Does attack #{a} have; 
      Advantage, Disadvantage or neither?"), %w(Advantage Disadvantage Neighter))
    if adv == "Advantage"
      attack = prompt.ask(box("For attack number #{a};
        What is your Attack Bonus? This normally includes;
        Your Strength or Dexterity Modifier,
        Proficiency Bonus,
        And any Magic Items Bonuses(such as +1 to attach rolls)"), default: 3+2, convert: :int)
      dc = prompt.ask(box("What is the expected Armour Class
        attack bumber #{a} is being made against?
        The default assumption is 16"), default: 16, convert: :int)
      hit=dpr.hit_adv(dc, attack)
    elsif adv == "Disadvantage"
      attack = prompt.ask(box("For attack number #{a};
        What is your Attack Bonus? This normally includes;
        Your Strength or Dexterity Modifier,
        Proficiency Bonus,
        And any Magic Items Bonuses(such as +1 to attach rolls)"), default: 3+2, convert: :int)
      dc = prompt.ask(box("What is the expected Armour Class
        attack bumber #{a} is being made against?
        The default assumption is 16"), default: 16, convert: :int)
      hit=dpr.hit_dis(dc, attack)
    elsif adv == "Neighter"
      attack = prompt.ask(box("For attack number #{a};
      What is your Attack Bonus? This normally includes;
      Your Strength or Dexterity Modifier,
      Proficiency Bonus,
      And any Magic Items Bonuses(such as +1 to attach rolls)"), default: 3+2, convert: :int)
      dc = prompt.ask(box("What is the expected Armour Class
      attack bumber #{a} is being made against?
      The default assumption is 16"), default: 16, convert: :int)
      hit=dpr.hit(dc, attack)
    end
    continue
    box("Now lets work out the Damage Dice for the attack")
    continue
    type = prompt.ask(box("How many different types of dice 
      do you roll for attack number #{a}?
      Type refers to the specific dice varient, 
      d4 and d6 are different Types of dice"), default: 1, convert: :int)
    d=(1..type.to_i).to_a
    d.each do |n|
      value = prompt.ask(box("What is the type of dice?
        Example for a d4 you should enter 4"),default: 4, convert: :int)
      number = prompt.ask(box("How many of this type of dice do you roll?"), default: 1, convert: :int)
      dice=dpr.dice(value, number)
      d[d.index(n)]=dice
      continue
      next
    end
    damage=d.sum
    box("Now lets move onto Attack Damage Bonuses")
    continue
    bonus = prompt.ask(box("What do you add to your damage roll for
      attack number #{a}?
      Normally you add the same ability modifier used for attacking,
      and any Magic Item Bonuses to Damage Rolls"), default: 3, convert: :int)
    continue
    box("Now Lets work out your crit chance")
    continue
    p adv
    if adv == "Advantage"
      crit=prompt.ask(box("What is the minimum number needed for attack
        number #{a} to count as a critical hit?"), default: 20, convert: :int)
      crit_chance=dpr.crit_adv(crit)
    elsif adv == "Disadvantage"
      crit=prompt.ask(box("What is the minimum number needed for attack
        number #{a} to count as a critical hit?"), default: 20, convert: :int)
      crit_chance=dpr.crit_dis(crit)
    else
      crit=prompt.ask(box("What is the minimum number needed for attack
        number #{a} to count as a critical hit?"), default: 20, convert: :int)
      crit_chance=dpr.crit(crit)
    end
    dpa=dpr.dpa(hit, damage, bonus, crit_chance)
    attacks[attacks.index(a)]=dpa
    puts "The Damage this attack deals on average is #{dpa}\n"
    continue
    next
  end
  box("Your Damage per round for your character is #{attacks.sum.round(2)}")
else
  adv = prompt.select(box("Does the target have; 
    Advantage, Disadvantage or neither?"), %w(Advantage Disadvantage Neighter))
  if adv == "Advantage"
    save = prompt.ask(box("What is the bonus your target has to the saving throw?"), default: 5, convert: :int)
    dc = prompt.ask(box("What is the DC of your Spell"), default: 13, convert: :int)
    hit=dpr.hit_adv(dc, save)
  elsif adv == "Disadvantage"
    save = prompt.ask(box("What is the bonus your target has to the saving throw?"), default: 5, convert: :int)
    dc = prompt.ask(box("What is the DC of your Spell"), default: 13, convert: :int)
    hit=dpr.hit_dis(dc, save)
  elsif adv == "Neighter"
    save = prompt.ask(box("What is the bonus your target has to the saving throw?"), default: 5, convert: :int)
    dc = prompt.ask(box("What is the DC of your Spell"), default: 13, convert: :int)
    hit=dpr.hit(dc, save)
  end
  hit = 1-hit
  continue
  box("Now lets work out the Damage Dice for spell")
  continue
  type = prompt.ask(box("How many different types of dice 
    do you roll for spells damage?
    Type refers to the specific dice varient, 
    d4 and d6 are different Types of dice"), default: 1, convert: :int)
  d=(1..type.to_i).to_a
  d.each do |n|
    value = prompt.ask(box("What is the type of dice?
      Example for a d4 you should enter 4"),default: 4, convert: :int)
    number = prompt.ask(box("How many of this type of dice do you roll?"), default: 1, convert: :int)
    dice=dpr.dice(value, number)
    d[d.index(n)]=dice
    continue
    next
  end
  damage=d.sum
  box("Now lets move onto Bonus Damage")
  continue
  bonus = prompt.ask(box("What if any is the addtional damage added to the spells' damage dice"), default: 0, convert: :int)
  continue
  crit_chance = 0
  dpa=dpr.dpa(hit, damage, bonus, crit_chance)
  print "the Damage Per Round of the spell is #{dpa}\n"
end