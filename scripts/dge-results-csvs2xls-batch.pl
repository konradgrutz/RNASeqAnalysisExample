# 
# read multiple csvs and save them to one xls
# into multiple sheets 
use warnings;
use strict;
use Spreadsheet::WriteExcel;


die "ERROR: need at least 6 parameters: separator (e.g. \"\\t\"), how many header lines, how many fixed columns, xls file to write data to, csv file(s), sheet names for each csv (<31 characters)\n\n" if(@ARGV<6);

my $separator = shift @ARGV;
my $nbHeaderLines = shift @ARGV;
my $nbFixedCols = shift @ARGV;
my $outfile = shift @ARGV;
die "ERROR: outfile must be *.xls, outfile given: $outfile\n" unless($outfile =~/xls$/);
my @infiles = @ARGV[0..(scalar(@ARGV)/2-1)];
my @sheetnames= @ARGV[(scalar(@ARGV)/2)..$#ARGV];

# check that infiles end on csv, to not confuse with sheet names:
for(@infiles) {
	unless(/\.csv$/) {die"ERROR: in files must end on .csv\n\n";}
}
# check that sheetnames don't end on csv, to not confuse with csv files
for(@sheetnames) {
	if(/\.csv$/) {die"ERROR: sheet names must not end on .csv\n\n";}
}
print "outfile:\n  $outfile\ninfiles:\n  @infiles\nsheet names:\n  @sheetnames\n";

my $workbook = Spreadsheet::WriteExcel->new($outfile);

my $headFormat = $workbook->add_format();
$headFormat->set_bold();
$headFormat->set_rotation(45);

my $worksheet;
my (@tmp,@data);
for my $i(0..$#infiles) {
	$worksheet = $workbook->add_worksheet($sheetnames[$i]);
	
	open IN, $infiles[$i];
	@tmp = <IN>;
	chomp @tmp;
	close IN;
	@data=();
	# write header, with format
	# n.b. header is 2 columns high
	for (0..($nbHeaderLines-1)) {
		$worksheet -> write_row($_,0,[split(/$separator/,$tmp[$_])],$headFormat);
	}
	
	for my $j($nbHeaderLines..$#tmp) {	
		push @data , [split(/$separator/,$tmp[$j])];
#		print "@data\n";
	}
	$worksheet -> write_col($nbHeaderLines,0,\@data);
	$worksheet->freeze_panes($nbHeaderLines, $nbFixedCols);
	for (0..($nbHeaderLines-1)) {
		$worksheet->set_row($_,80);
	}
	$worksheet->set_column(0,0,20);
#	$worksheet->autofilter(0, 0, 1, 40);  # does not work ?!
}

# 
