package DataAPIExtension::Endpoint::Plugin;

use warnings;
use strict;
use MT::DataAPI::Endpoint::Common;

sub _hdlr_list {
    my ( $app, $endpoint ) = @_;
    my $user = get_target_user(@_);
    # ここでユーザの権限などを確認すべき
    
    my @items = ();
    for my $sig ( keys %MT::Plugins ) {
        my $sub = $sig =~ m!/! ? 1 : 0;
        my $plugin = $MT::Plugins{$sig}{object};
        next if $plugin && !$plugin->isa('MT::Plugin');
        my %item = map{ $_ => $plugin->$_ } qw(id key name version);
        push @items, \%item;
    }
    
    +{  totalResults => scalar(@items),
        items => \@items
    };
    
}

1;