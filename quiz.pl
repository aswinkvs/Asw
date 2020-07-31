#Admins have to prepare MCQ in a certain format: firsr line Question, second line option and third line answer choice alphabet without leaving blank lines
#number of questions can be five and options can be four
#Admin password is 1234
#Admin can upload new file of question by entering password
#Result of the quiz can be obtained in file Result.txt

use strict;
use warnings;

print "Welcome to Quiz Master\n";
start:
print "Type 'U' for User, 'A' for Admins and 'E' to Exit:\n";
my $input = <STDIN>;
chomp $input;
 my $name;
if($input eq "A")
  {
   LOOP: print "\n Enter your password or Enter 'E' to Exit\n";
   my $pwd =<STDIN>;
   chomp $pwd;
     if ($pwd eq "E")
     {
	   exit 0;
     }
     elsif($pwd =='1234')
	 {
		print "\nEnter the file name with extension to modify the questions and answers\n";
		my $filename =<STDIN>;
		chomp $filename;
		open (FQ, ">", "qlink.txt")|| die $!;
		print FQ $filename;
		close FQ;
		print "\nChanges saved\n";
		exit 0;
	 }
	 else 
	 {
	  print "Wrong Password\n";
      goto LOOP;
	 }
   }
elsif($input eq "E")
{
 exit 0;
}
elsif($input eq "U")
{
 print "Enter your name or ID\n";
 $name=<STDIN>;
 chomp $name;
}
else
{
print"Incorrect choice\n";
goto start;
}

{
 print "\nChoose the correct answer among the options given\nYour answer to each question should be either A or B or C or D depending on the correct choice\n\n";

open (FQ, "qlink.txt")||die $!;
my $line = <FQ>;
open (FH, "$line")||die $!;

my @qstn =<FH>;
my $score=0;

for(my $i=0;$i<15;)
{
print "\n";
print @qstn[$i,$i+1];
print "\nEnter your choice (A/B/C/D)\n";
my $choice =<STDIN>;
chomp $choice;
chomp $qstn[$i+2];
if($choice eq $qstn[$i+2])
{
	print " Correct answer!!!\n";
	$score++;
}
else
{
	print " Wrong!!!\n The right answer is option $qstn[$i+2]\n";
}
$i+=3;
}

print "\n Quiz over!\n Your score is $score out of 5\n";
open (RLT, ">>","Result.txt")|| die $!;
print RLT "\n Candidate ID :$name  \n Score : $score \n";
close RLT;
}