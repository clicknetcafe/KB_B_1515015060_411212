/*
Program Logika Perpindahan 
Disediakan 3 tempat kaset, A, B, C (kiri, tengah, kanan)
yang paling kiri ada tumpukan kaset berjumlah 3
Tumpukan kaset itu mempunyai nomor urut 1,2,3 dengan nomor 1 di posisi paling bawah

Ini adalah logika perpindahan kaset dari kiri menuju kanan dengan tetap urut 1,2,3 

*/		

domains					% menyatakan jenis variabel
  pos =kanan;tengah;kiri		% variabel pos berisi nilai yaitu kanan, tengah, dan kiri

predicates
  urut(integer)
  posisi(integer,pos,pos,pos)
  pindah(pos,pos)

clauses					% berisi fakta
  urut(X):-
	posisi(X,kiri,tengah,kanan).	% posisi awal 
	posisi(1,A,_,C):-		% jika x=1, maka tempat di tengah dilewati 
	pindah(A,C),			% pindah dari kiri ke kanan
	!.

  posisi(X,A,B,C):-			
	X1=X-1,				% deklarasi pengurutan X1 sama dengan nilai X dikurangi 1
	posisi(X1,A,C,B),		% akan menukar tempat dari B ke C dan otomatiis C ke B
	pindah(A,C),			% memberi tahu bahwa ada perpindahan A,C
	posisi(X1,B,A,C).		% penpindahan kaset bila ada XI menjadi A,B,C

  pindah(Pos1, Pos2):-
	write("\nMemindah piringan kaset dari ", Pos1, " ke ", Pos2).	%write seperti perintah print pada c++
GOAL
  urut(3).	% melakukan 3 kali



