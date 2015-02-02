#### Perlのオブジェクト指向のカプセル化
- カプセル化とそのメリット
- カプセル化のサンプル

------

##### カプセル化とそのメリット
オブジェクト指向のカプセル化とは、データ構造やメソッドをクラスに閉じ込め、クラス設計者が認めたプロパティのみを、クラス設計者が認めたメソッドで公開すること。  

->安易にデータやメソッドにアクセスすることを防ぐ。  
  
ゲッター(データを得るメソッド)、セッター(データをセットするメソッド)を使えば、カプセル化をしながら、使い勝手を向上させられる。  
  
->よりデータ設計、クラス設計が重要になる。  
  
Perlのデフォルトのカプセル化は不完全。  
  
->破ろうと思えば敗れる。

##### カプセル化のサンプル


triangle.pl
``` triangle.pl
#! usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

use Triangle;

my $tri = Triangle->new(3,4,5);

my $space = $tri->space;
	
print "sides are ",join(",",$tri->getSides),"\n";
print $space."\n";

$tri->setSides(4,5,3);
print join(",",$tri->getSides)."\n";
```

triangle.pm
```
package Triangle;
use Carp qw(croak);

#面積を求めるサブルーチン
my $space = sub{
	my($a,$b,$c) = @_;
	my $s = ($a + $b + $c)/2;
	my $inroot = $s*($s-$a)*($s-$b)*($s-$c);

	if($inroot >= 0){
		return sqrt($inroot);
	}
	else{
		croak "you cannot construct the triangle with the side $a,$b,$c";
	}
};

#newオブジェクト
sub new{
	my ($class,$a,$b,$c) = @_;
	bless { a => $a,b => $b,c => $c,s => $space->($a,$b,$c)};
}

#面積を返す
sub space{
	my $self = shift;
	warn "You are about to calculate the space of ",ref($self),"!!! \n";
	return $self->{s};
}

#値を得る
sub getSides{
	my $self = shift;
	return ($self->{a},$self->{b},$self->{c});
}

#値をセットする
sub setSides{
    my ($self,$a,$b,$c) = @_;
    $self->{a} = $a;
    $self->{b} = $b;
    $self->{c} = $c;
    $self->{s} = $space->($a,$b,$c);
}


1;
```