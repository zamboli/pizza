use Irssi;
use strict;
use Time::Local;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
    authors     => 'zamboli',
    name        => 'PizzaBot 9000',
    contact=> '',
    description => 'pizza generator',
    license     => 'Public Domain',
    changed=> 'HAHAHA'
    );
=pod
use Inline Python => <<'END_PYTHON';
def pizza():
    import random
    
    def random_line(afile):
        line = next(afile)
        for num, aline in enumerate(afile):
            if random.randrange(num + 2): continue
            line = aline
        return line

    noun_file = open('/Users/greg/.irssi/scripts/nouns.txt', 'r')
    pizza = "pizza %s" % str(random_line(noun_file)).rstrip()
    noun_file.close()
    return pizza

END_PYTHON
=cut
sub pizza {
	sub random_word {
		my $file = '/Users/greg/.irssi/scripts/nouns.txt';
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

my $start_time = time();
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

#sub cmd_pizza {
#    my ($server, $witem) = @_;
#    my $pizza = pizza();
#    my $target = "#macinto
#sh";
#    $server->command("msg $witem $pizza"); # if ($msg =~ m/hello/i);                                                                                      
#    Irssi::print("$target : me : $pizza");
#}

#Irssi::command_bind('pizza', 'cmd_pizza');
