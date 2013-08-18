#!perl
use strict;
use warnings;
use Fatal qw(open close);
use Test::More;
use File::Temp qw(tempdir);

{
    #my $tempdir = tempdir(CLEANUP => 1);
    my $tempdir = "temp"; mkdir $tempdir;

    system("./emcc-jsx add.c $tempdir") == 0 or die;

    # show the content of the generated JSX file
    {
        open my($in), "<", "$tempdir/add.c.jsx";
        local $/;
        note <$in>;
    }

    my $out;

    open $out, ">", "$tempdir/main.jsx";
    print $out <<'MAIN';
import "./add.c.jsx";

class _Main {
  static function main(args : string[]) : void {
    log EMS.add(10, 20);
    log EMS.add(15, 20);
  }
}
MAIN
    close $out;
    is scalar(`jsx --run "$tempdir/main.jsx"`), "30\n35\n", "add()";

    open $out, ">", "$tempdir/main.jsx";
    print $out <<'MAIN';
import "./add.c.jsx";

class _Main {
  static function main(args : string[]) : void {
    EMS.myPuts("foo");
    EMS.myPuts("bar");
  }
}
MAIN
    close $out;
    is scalar(`jsx --run "$tempdir/main.jsx"`), "foo\nbar\n", "myPuts()";

    open $out, ">", "$tempdir/main.jsx";
    print $out <<'MAIN';
import "./add.c.jsx";

class _Main {
  static function main(args : string[]) : void {
    log EMS.addInt(2, 3.5);
  }
}
MAIN
    close $out;
    is scalar(`jsx --run "$tempdir/main.jsx"`), "5\n", "addInt()";
}

done_testing;
