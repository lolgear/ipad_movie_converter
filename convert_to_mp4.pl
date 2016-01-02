use Getopt::Long;
use Data::Dumper;
use File::Spec;
use File::Basename;
sub MainWork{
	my $hash = shift;
	my ($infile) = $hash->{'infile'};
	my $infile_copy = fileparse($infile,'.avi');
	my ($outfile) = $hash->{'outfile'} || ($infile_copy.'.mp4');

	unless (-e $infile) {
		my $error = Dumper $infile;
		die "this is no file! $error $!\n";
	}

	my $tool = 'ffmpeg';
	my $before_options = '-fflags +genpts';
	my $infile_string = qq(-i \"$infile\");
	my $options = '-map 0:0 -map 0:1 -map 0:2 -c:a:0 mp3 -c:a:1 mp3 -vb 1000k';
	my $outfile_string = qq(\"$outfile\");
	my $exec_string = join (' ', $tool, $before_options, $infile_string, $options, $outfile_string);
	print "I will do: $exec_string\n";
	print `$exec_string`;
}

my $infile;
my $outfile;

GetOptions(
	'input=s' => \$infile,
	'output=s' => \$outfile
	);

MainWork({'infile' => $infile, 'outfile' => $outfile})