/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

trace
domains
  name,sex,occupation,object,vice,substance = symbol
  age=integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * fakta-fakta terkait pembunuhan * * */
clauses
  person(bert,55,m,carpenter).		% bert,55 tahun, laki-laki, tukang kayu
  person(allan,25,m,football_player).	% allan,25 tahun, laki-laki, pemain bola
  person(allan,25,m,butcher).		% allan, 25 tahun, laki-laki, tukang daging
  person(john,25,m,pickpocket).		% john, 25 tahun, laki-laki, pencuri

% perselingkuhan 
  had_affair(barbara,john).		
  had_affair(barbara,bert).
  had_affair(susan,john).

  killed_with(susan,club).
  killed(susan).

  motive(money).		% ada 3 motif, dimulai dari pertama yaitu uang, cemburu, dendam
  motive(jealousy).
  motive(righteousness).

  smeared_in(bert,blood).	% bert bernoda darah
  smeared_in(susan,blood).	% susan bernoda darah
  smeared_in(allan,mud).	% allan bernoda lumpur
  smeared_in(john,chocolate).	% john bernoda coklat
  smeared_in(barbara,chocolate).% barbara bernoda coklat	

  owns(bert,wooden_leg).  % bert mempunyai kayu pentung
  owns(john,pistol).

/* * * hal-hal untuk bahan penyelidikan * * */

  operates_identically(wooden_leg, club).	
  operates_identically(bar, club).
  operates_identically(pair_of_scissors, knife).
  operates_identically(football_boot, club).

  owns_probably(X,football_boot):-
	person(X,_,_,football_player).
  owns_probably(X,pair_of_scissors):-
	person(X,_,_,hairdresser).
  owns_probably(X,Object):-
	owns(X,Object).
  % logika bila bert mempunyai kayu pentung itu benar


/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	killed_with(susan,Weapon) ,		%kecurigaan pertama yaitu susan dibunuh dengan senjata
	operates_identically(Object,Weapon) ,	% objek memang senjata
	owns_probably(X,Object).		% pelaku mempunyai senjata

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */
  % motif laki-laki yang selingkuh dengan Susan
  suspect(X):-			
	motive(jealousy),	
	person(X,_,m,_),	
	had_affair(susan,X).

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */
  % dicurigai perempuan yang selingkuh dengan seseorang laik-laki yang dikenal susan 
  % di sini diketahui motif pembunuhannya yaitu kecemburuan karena susan selingkuh dengan seorang laki-laki
  suspect(X):-
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */
  % disini hanya pencopet yang mempnyai motif uang
  suspect(X):-
	motive(money),
	person(X,_,_,pickpocket).

  killer(Killer):-
	person(Killer,_,_,_),   % pelaku
	killed(Killed),		% Killed di dalam kurung merupakan korban. di atas jelas hanya ada susan
	Killed <> Killer, /* korban terbunuh bukan disebabkan bunuh diri */
	suspect(Killer),	% jelas pembunuhlah yang dicurigai
	smeared_in(Killer,Goo), % pembubuh ternodai
	smeared_in(Killed,Goo).	% korban juga ternodai

goal
  killer(X).
  /*
  pengecekan pertama yaitu memeriksa bert, dan selanjutnya diketahui bila yang terbunuh adalah susan.
  dan diketaui pula bila bert membunu dengan kayu pentung  
  jadi kesimpulannya bert membunuh susan karena dia selingkuh
  ditandai dengan keduanya mempunyai noda darah
  */
