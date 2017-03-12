
/*
	ada 4 teman bernama Vandi, Rendra, Eko, dan Rizki.
	mereka menghabiskan waktu dengan melakukan aktivitas. 
	namun aktivitas ini memiliki aturan yaitu 2 orang berenang, 
	1 orang memancing, dan 1 orang membaca. program ini akan 
	menampilkan kondisi dimana rizki tidak berenang dan 
	rendra tidak sedang membaca
*/

PREDICATES
    nondeterm aktivitas(string,string,string,string)
    nondeterm teman(string)
    nondeterm memancing(string)
    nondeterm membaca(string)
    nondeterm berenang(string, string)

CLAUSES
    teman(vandi).
    teman(rendra).
    teman(eko).
    teman(rizki).

    memancing(X):-
        teman(X).

    membaca(X):-
        teman(X),
        X<>"rendra".

    berenang(X,Y):-
        teman(X),
        teman(Y),
        X<>Y,
        X<>"rizki",
        Y<>"rizki".

    aktivitas(A,B,C,D):-
        teman(A),
        teman(B),
        teman(C),
        teman(D),
        berenang(A,B),
        memancing(C),
        membaca(D),
        A>B, A<>C, A<>D,
        B<>C, B<>D,
        C<>D.
GOAL
    aktivitas(A,B,C,D).