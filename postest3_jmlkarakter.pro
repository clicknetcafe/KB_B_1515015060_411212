domains
   deret=symbol*


predicates
   karakter(deret)
   jmlkarakter(deret,integer)

    
clauses
   karakter(X):-
      jmlkarakter(X,Jumlah),
      write("\nPanjang Karakter : "),
      write(Jumlah).
        
   jmlkarakter([],X):-
      X=0.
    
   jmlkarakter([X|Belakang],Jumlah):-
      jmlkarakter(Belakang,Pre),
      Jumlah = Pre + 1.
        
 
Goal
   karakter([a,b,c,d,e]),nl.