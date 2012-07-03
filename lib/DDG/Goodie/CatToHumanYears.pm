package DDG::Goodie::CatToHumanYears;

use DDG::Goodie;

triggers any => 'cat', 'dog';

zci is_cached => 1;
zci answer_type => "conversion";

handle query_lc => sub {
	# how old is my 15 yr cat in human years?
	# how old is my 15 yr old cat in human years?
	# how old is my 15 year old cat in human years?
	# 15 yr old cat in human years?
	# 15 yr old cat in human yrs?
	# how old is 15 cat years
	# how old is 15 cat years?
	# how olds my 15 yr old cat
	# how old's my 15 yr old cat
	# how old is my 15 yr old cat

	#return unless $_ =~ qr/((how old('?s| is)? my)? )?(\d+) (cat ?)((yr|year)'?s) ?(old )? cat in human years\??/;

	my $num = $_ =~ /(\d+)/;

	# bail if they're dumb
	if ($num <= 0) {
		return;
	}

	sub get_cat_months {
		my ( $months ) = @_;

		if ($months <= 0) {
			return -1;
		}
		return (($months - 12) / 12) * 4 * 12
	}

	my $cat_months = 0;
	if ($_ =~ /month?s/) {
		$cat_months = $num;
	} elsif ($_ =~ /(?:year|yr)?s/) {
		$cat_months = 12 * $num;
	}

	my $human_months = 0;
	if ($cat_months >= 12) {
		$human_months = 192;
	}

	$cat_months = get_cat_months($cat_months);
	return if $cat_months == -1;

	$human_months = $human_months + $cat_months;

	return "Your cat is " . $human_months/12 " human years old.";
};

1;

