# paizaのオンラインハッカソン

+ URL
    + https://paiza.jp/poh/kirishima
+ 結果
    + http://paiza.jp/poh/kirishima/result/b86f7eb5851361fe2953c2defced788d
+ Gist
    + https://gist.github.com/yaasita/4ec06b36f81306acfdf9

# TODO

min_costのループを2文探索法にすれば早くなる？
⇒組み合わせ爆発により$PEOPLES=50でmin_cost(25)とかやると死ぬのでダメそう

    # 最小値計算
    #my ($min,$mid,$max);
    #my ($minv,$midv,$maxv);
    #$min = 1;
    #$max = $COMPANY_NUM;
    #$mid = $min + int (($max - $min)/2);
    #$maxv = min_cost($max);
    #$minv = min_cost($min);
    #$midv = min_cost($mid);
    #while ($max - $mid > 1){
    #    if ($midv != -1){
    #        $max = $mid;
    #        $maxv = $midv;
    #    }
    #    else {
    #        $min = $mid;
    #        $minv = $midv;
    #    }
    #    $mid = $min + int (($max - $min)/2);
    #    $midv = min_cost($mid);
    #}
    #if ($minv == -1 and $midv != -1){
    #    say $midv;
    #}
    #else {
    #    say "$maxv , $max";
    #}
    #say min_cost(3);

# データサンプル

## 例1

    __DATA__
    250
    5
    35 3640
    33 2706
    98 9810
    57 5472
    95 7790 

⇒答えは `6600`

## 例2

    __DATA__
    250
    5
    35 3640
    33 2706
    98 9810
    57 5472
    95 7790 

⇒答えは `23072`
