use Irssi;
use strict;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
    authors     => 'zamboli',
    name        => 'pizza noun',
    contact=> '',
    description => 'pizza generator',
    license     => 'Public Domain',
    changed=> 'HAHAHA'
    );

sub pizza {
	sub random_word {
		my $file = './nouns.txt';
	        open(INFO, $file);
	        my @lines = <INFO>;
	        my $line; 
	        my $i = 0;
	        foreach(@lines) {
	            $i++;
	            my $random_number = int(rand($i + 2));
	            if ($random_number > 0) {next;}
	            $line = $lines[$i];
	        }
        return $line;
	}

    return my $pie = join " ", "pizza", random_word();
}

Irssi::signal_add 'message public', 'sig_message_public';

sub sig_message_public {
    my ($server, $msg, $nick, $nick_addr, $target) = @_;
    if ($msg =~ m/!pizza/i)
    {
        my $pizza = pizza();
	$server->command("msg $target $pizza");
	Irssi::print("$target : $nick : $pizza");
    }
}
