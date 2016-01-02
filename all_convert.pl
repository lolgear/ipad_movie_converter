use Getopt::Long;
use Data::Dumper;

sub getAll{
	my $directory = shift;
	my @get_all = qx(ls $directory);
	grep{/[.]avi$/} map {chomp; $_ }(@get_all);
}

sub MainWork{
	my $directory = %{+shift}->{'directory'};
	# directory to search avi
	unless (-d $directory){
		my $error = Dumper($directory);	
		die "can't see a directory! $error! $!\n";
	}
	# take all files
	my @all = getAll($directory);
	for (@all) {
		
		my $exec_string = 'perl convert_to_mp4.pl -i '.$_;
		print 'I will do: '. $exec_string, "\n";
		print `$exec_string`, "\n";
	}
}


my $directory;

GetOptions(
	'-directory=s',\$directory
	);

MainWork({'directory' => $directory});