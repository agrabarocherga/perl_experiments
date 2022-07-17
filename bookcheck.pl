#!perl
use File::Find;

my $dir_unsorted = "/home/mobaxterm/Desktop/Книги в беспорядке/";
my $dir_sorted = "/mnt/g/Мой диск/TechBooks/";
my %books;

sub wanted { 
    $f = $File::Find::name;
    if (! -d $f) {
        $books{"$f"} = -s $f;
    }
}

print "Сканируем папку\n$dir_unsorted\n";
find(\&wanted, $dir_unsorted);

print "Сканируем папку\n$dir_sorted\n";
find(\&wanted, $dir_sorted);

foreach(keys(%books)) {
    $top_key = $_;
    foreach(keys(%books)) {
        if (($books{$top_key} == $books{$_}) && ! ($top_key eq $_)) { 
            $_ =~ m{.*беспорядке.*} && print "Удалю $_\n";
            delete($books{$_});
        }
    }
}