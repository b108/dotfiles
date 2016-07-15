set foldmethod=expr
set foldexpr=getline(v:lnum-1)=~'^\\s*sub\\s\\+\\w\\+\\s*{\\s*$'?'>1':getline(v:lnum+1)=~'^}$'?'s1':'-1'
