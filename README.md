# ***D&D DPS Calculator by Will Swan***

[GitHub Repo](https://github.com/wSwanepoel199/WillemSwanepoelT1A3)

<a href="https://ttytoolkit.org/" target="_blank">"TTY-Toolkit"</a> is licensed under <a href="http://creativecommons.org/licenses/by/4.0" target="_blank">CC BY 4.0</a>

## *Software Development Plan*

This Application is intended to assist inexperienced players with calculating their average Damage per Round for their character

Getting into optomisation in any Table Top Role Playing Game can be difficult and take several hours learning the maths needed to figure out what is and isn't effective. This application is intended to alleviate this by providing a simple interfact to input basic character information and it will do the maths for you. Allowing a lower barrier of entry to the optomisation field of TTRPGs.

The target audience are any players seeking to improve on their D&D builds but do not possess the knowledge of working out how effective their damage dealing abilities are. As such by providing an easy to use interface to take in all needed information, this application allows such players to optomise without needing the knowledge of the complicated maths behind the scenes.

## *Feature List*
 -  Provide option for calculating damage of attack rolls or saving throws.
 - Allows the input of multiple attacks, and sums damage for a final total.
 - Supports the use of multile types of dice for one attack allowing users to calculate the dpr for more complicated characters, such as rogues.
 - Only supports Integer inputs and will refuse any other datatype.
 - Provides a more user friendly interfact by use of Gems that allow for text contianing boxes and more detailed user prompts.
 - Comes with Default inputs for each question as to allow for situations where specific information is not known such as an enemies Armour Class or Saving Throw Bonus.

## *User Interaction*

The application is simple on an input level, It provides break periods to inform the user which types of information is sought. Due to inbuilt capabilities of used Gems many of the prompts show how to use them or provide the default input if needed, Enter is all that is required to process input or skip by entering default options.

Due to how the application is built errors often do not occur or it will refuse to accept inputs it can not use. However if wrong information has been entered the only fix is to kill the application and resume from the start.

## *UML Diagram generated using RubyMine*
<!-- probably not what was wanted but time constraints did not allow me to properly learn how to make one myself -->
![UML Diagram](https://github.com/wSwanepoel199/WillemSwanepoelT1A3/blob/main/docs/diagram.png?raw=true)

## *Planned Features*

| Syntax | Description |
| ----------- | ----------- |
| Check | Item |
| [x] | Impliment Class to contain DPR calculations |
| [x] | Impliment variables to collect desired information and store it |
| [x] | Impliment equations that utilise corret variables |
| [x] | Impliment gem, "tty-prompt" inorder to collect user input |
| [x] | Ensure DPR is correctly using, user input|
| [x] | Impliment IF statements and Loops to ensure information is accuratly collected |
| [x] | Calculate DPR based of final input which was collected via loops |
| [x] | Display accurate DPR calculations using well known examples such as the Warlock Baseline |
| [x] | Impliment Gem to improve user experience by surrounding prompts within boxes |
| [x] | Impliment Gem to clean up clutter by clearing screen when moving on to new sections |
| [x] | Impliment a Save DPR calculator along with the expected normal attack |


## ***Help Documentation***

Run Run.sh or follow instructions below;

Ensure Ruby Version 3.0.0p0 is installed

Ensure RubyGem version 3.2.3 is installed

Use RubyGem to install bundler version 2.2.3.
> gem install bundler --version 2.2.3

Ensure D&D_DPR_Calculator.rb and accompanying Gemfile is in the same folder

CD into folder containing script and Gemfile

use Bundler to install gems
> bundle

or

> bundle install

Run script via
> ./D&D_DPR_Calculator.rb