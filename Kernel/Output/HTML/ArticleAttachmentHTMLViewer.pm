# --
# Kernel/Output/HTML/ArticleAttachmentHTMLViewer.pm
# Copyright (C) 2001-2012 OTRS AG, http://otrs.org/
# --
# $Id: ArticleAttachmentHTMLViewer.pm,v 1.12 2012-11-12 18:36:23 mh Exp $
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.
# --

package Kernel::Output::HTML::ArticleAttachmentHTMLViewer;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION = qw($Revision: 1.12 $) [1];

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # get needed objects
    for (qw(ConfigObject LogObject DBObject LayoutObject UserID TicketObject ArticleID)) {
        $Self->{$_} = $Param{$_} || die "Got no $_!";
    }
    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(File Article)) {
        if ( !$Param{$_} ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    # check if config exists
    if ( $Self->{ConfigObject}->Get('MIME-Viewer') ) {
        for ( keys %{ $Self->{ConfigObject}->Get('MIME-Viewer') } ) {
            if ( $Param{File}->{ContentType} =~ /^$_/i ) {
                return (
                    %{ $Param{File} },
                    Action => 'Viewer',
                    Link =>
                        "\$Env{\"Baselink\"}Action=AgentTicketAttachment;ArticleID=$Param{Article}->{ArticleID};FileID=$Param{File}->{FileID};Viewer=1",
                    Target => 'target="attachment"',
                    Class  => 'ViewAttachment',
                );
            }
        }
    }
    return ();
}

1;
