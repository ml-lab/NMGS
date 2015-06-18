#!/usr/bin/perl

use strict;
my $minRare = $ARGV[0];
my $line = <STDIN>;
chomp($line);
my @tokens = split(/,/,$line);
shift(@tokens);

my @samples  = @tokens;
my $nSamples = scalar(@samples);
my @values   = ();
my @OTUs     = ();
my @totals   = ();

my $i = 0;
while($line = <STDIN>){
  chomp($line);

  @tokens = split(/,/,$line);

  push(@OTUs, shift(@tokens));

  my $j = 0;
  foreach my $tok(@tokens){
    $values[$j][$i] = $tok;
    $totals[$i] += $tok;
    $j++;
  }

  $i++;
}
my $nOTUs = scalar(@OTUs);


printf("OTU,");
my $stringName = join(",",@samples);
print "$stringName\n";

for(my $j = 0; $j < $nOTUs; $j++){
  #print "$totals[$j] $j\n";
  if($totals[$j] > $minRare){

    my $i = 0;
    printf("%s,",$OTUs[$j]);
    for($i = 0; $i < $nSamples - 1; $i++){
	printf("%d,", $values[$i][$j]);
    } 
    printf("%d\n",$values[$i][$j]);
  }	
}
