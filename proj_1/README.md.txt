Projekt: P��stupov� termin�l
1. Zad�n�
1. Seznamte se s p��pravkem FITKit a zp�sobem p�ipojen� jeho perif�ri�, zejm�na
kl�vesnice a LCD displeje.
2. Prostudujte si zdrojov� k�dy projektu v jazyce VHDL.
3. Navrhn�te ��dic� jednotku (kone�n� automat) jednoduch�ho p��stupov�ho termin�lu.
4. Navr�enou ��dic� jednotku implementujte v jazyce VHDL a ov��te jej� funk�nost
p��mo na p��pravku FITKit.
2. Architektura p��stupov�ho termin�lu
P��stupov� termin�l je jednoduch� elektronick� za��zen�, kter� povoluje opr�vn�n�m
u�ivatel�m vstup do chr�n�n�ch objekt�. Obvykle je slo�eno z kl�vesnice, LCD displeje a
��dic� jednotky. Ka�d� u�ivatel mus� p�ed vstupem do objektu vy�ukat na kl�vesnici
p��stupov�ho termin�lu aktiva�n� k�d a na jeho z�klad� z�sk� nebo nez�sk� p��stup do objektu.
C�lem tohoto projektu je realizovat takov�to p��stupov� termin�l na p��pravku FITKit, kde je
k dispozici kl�vesnice, LCD display a FPGA hradlov� pole p�ipojen� k ob�ma t�mto
perif�ri�m. �lohou FPGA �ipu bude sledovat vstupy kl�vesnice, vyhodnocovat zadan�
vstupn� k�d a vypisovat p��slu�n� odezvy na LCD displeji. Architektura FPGA �ipu je
uvedena na n�sleduj�c�m obr�zku.
Obr�zek 1. Architektura aplikace uvnit� FPGA
Funkce obvodu je n�sleduj�c�:
? Vstupy z kl�vesnice jsou pravideln� testov�ny pomoc� �adi�e kl�vesnice (Keyboard
Controller). Jakmile je detekov�n stisk n�kter� kl�vesy, nastav� �adi� na sv�m v�stupu
KEY jeden z 16-ti sign�l� odpov�daj�c� ��slu stisknut� kl�vesy (sign�ly KEY(0..9)
odpov�daj� kl�ves�m 0..9, sign�ly KEY(10..13) odpov�daj� kl�ves�m A..D, sign�l
KEY(14) odpov�d� kl�vese "*", sign�l KEY(15) odpov�d� kl�vese "#").
  V�stupn� sign�ly z kl�vesnice jsou d�le p�ipojeny ke kone�n�mu automatu (FSM),
kter� ovl�d� zb�vaj�c� ��sti obvodu. Automat sleduje posloupnost stisknut�ch kl�ves,
v pr�b�hu zad�v�n� k�du vypisuje na LCD displeji znak "*" a po potvrzen� k�du
kl�vesou "#" vyp�e na displej zpr�vu "Pristup povolen" nebo "Pristup odepren".
Op�tovn�m stisknut�m kl�vesy "#" p�ech�z� obvod op�t do stavu �ekaj�c�ho na vstupn�
k�d.
  Textov� zpr�vy "Pristup povolen" resp. "Pristup odepren" jsou ulo�eny ve dvou
pam�ov�ch modulech typu ROM. Ka�d� z modul� obsahuje 16 osmi-bitov�ch
polo�ek obsahuj�c�ch jednu ze zpr�v.
  V okam�iku potvrzen� vstupn�ho k�du kl�vesou "#", aktivuje automat Clock Enable
sign�l 4-bitov�ho ��ta�e (COUNTER), kter� je p�ipojen na adresov� vstupy
pam�ov�ch modul� a zp�sob� tak vy�ten� jejich obsahu na v�stup.
  V�stupy pam�ov�ch modul� jsou d�le p�ipojeny na dvou-vstup� multiplexor
(MX_MEM). V p��pad�, �e byl k�d spr�vn� zad�n, potom automat vybere skrze tento
multiplexor zpr�vu "P��stup povolen", v opa�n�m p��pad� vybere zpr�vu "Pristup
odepren".
  V�stup multiplexoru (MX_MEM) je p�ipojen na dal�� dvou-vstup� multiplexor
(MX_LCD). Tento multiplexor p�ep�n� na sv�j v�stup bu� zpr�vu ulo�enou v
pam�ov�ch modulech nebo znak "*" podle toho, zda se p��stupov� termin�l nach�z�
ve stavu zad�v�n� k�du nebo ve stavu vypisuj�c�m v�stupn� zpr�vu.
  V�stup multiplexoru (MX_LCD) je p�ipojen na datov� vstup �adi�e LCD displeje
(LCD DISPLAY CONTROLLER) a reprezentuje znaky, kter� se budou zobrazovat na
displeji. �adi� je ovl�d�n pomoc� dvou sign�l� WRITE a CLEAR. Aktivace sign�lu
WRITE zp�sob� z�pis znaku na displeji, zat�mco aktivace sign�lu CLEAR displej
vyma�e a p�iprav� na z�pis nov� sekvence znak�.
Architektura FPGA �ipu je p�ipravena tak, �e v�e krom� kone�n�ho automatu FSM je
ji� naimplementov�no v jazyce VHDL. C�lem toho projektu je proto spr�vn� navrhnout
a implementovat pr�v� tento automat ��d�c� zb�vaj�c� ��sti obvodu.
3. Postup pr�ce
1. Pro vypracov�n� projektu a jeho ov��en� na p��pravku FITkit jsou pot�eba n�sleduj�c�
n�stroje: MSPGCC (kompil�tor zdrojov�ch souboru pro mikrokontrol�r MSP430),
Xilinx ISE (v�vojov� prost�ed� pro synt�zu obvod� v jazyce VHDL do �ipu FPGA) a
QDevKit (prost�ed� pro pr�ci s p��pravkem FITkit). S ohledem na n�ro�nost instalace
v�ech t�chto n�stroj� byl pro V�s p�ipraven obraz virtu�ln�ho stroje, kde jsou v�echny
tyto n�stroje ji� nainstalov�ny. Obraz tohoto virtu�ln�ho stroje si st�hn�te z priv�tn�ch
str�nek FITkitu. Pro spu�t�n� tohoto stroje si nainstalujte voln� dostupn� program
VirtualBox.
2. P�ipojte FITkit k po��ta�i.
3. Spus�te program VirtualBox a p�ipojte obraz virtu�ln�ho stroje. V nastaven� USB
za��zen� povolte FTDI Dual RS232 (viz obr�zek) a virtu�ln� stroj spus�te.
D�le�it� pozn�mka: Pou��vejte VirualBox verze 5 a vy���. Star�� verze nepodporuj�
USB 3.0, a proto pokud m�te na sv�m po��ta�i pouze porty USB 3.0, potom se FITkit
nebude korektn� propagovat z va�eho syst�mu a� do virtu�ln�ho stroje.
4. Z informa�n�ho syst�mu si st�hn�te arch�v zdrojov�ch soubor� projekt.zip a rozbalte si
jej do adres��e C:\FitkitSVN\apps\demo\terminal\ (uvnit� virtu�ln�ho stroje).
Po spu�t�n� aplikace QDevKit by se V�m m�la objevit v z�lo�ce Demo aplikace nov�
polo�ka s n�zvem P��stupov� termin�l (viz obr�zek). Od tohoto okam�iku m��ete
aplikaci p�ekl�dat, simulovat, nahr�vat do p��pravku FITkit a n�sledn� spou�t�t
(v�echny tyto volby jsou dostupn� skrze kontextov� menu vyvolan� kliknut�m prav�ho
tla��tka my�i na polo�ku P��stupov� termin�l).
5. V informa�n�m syst�mu tak� naleznete soubor kod.txt se seznamem p��stupov�ch
k�d�. Uvnit� tohoto souboru vyhledejte sv�j login a u n�j naleznete tak� dva
p��stupov� k�dy pro V� projekt.
6. Prostudujte si zdrojov� k�dy projektu v jazyce VHDL a zp�sob zapojen� jeho
jednotliv�ch ��st�.
7. Navrhn�te ��dic� jednotku (kone�n� automat) jednoduch�ho p��stupov�ho termin�lu.
P�i n�vrhu dbejte na n�sleduj�c� po�adavky:
  P��stupov� termin�l mus� akceptovat pouze Va�e dva p��stupov� k�dy (tzn.
termin�l vyp�e hl�en� �Pristup povolen�, pokud u�ivatel zad� spr�vn� libovoln� z
obou k�d�).
  Pokud u�ivatel v pr�b�hu zad�v�n� k�du stiskne �patnou kl�vesu, nesm� to V�
automat nijak d�t najevo, dokud nen� stisknuta potvrzovac� kl�vesa "#".
  Identifikujte Mealyho a Moorovy v�stupy.
  Sestavte si graf p�echod� automatu.
  P�i sestavov�n� grafu p�echodu automatu vznik� obecn� velk� mno�stv� p�echod�
mezi stavy, nebo� je pot�eba reagovat na v�echny mo�n� stisknut� kl�vesy (celkem
16 mo�nost�). Pro zjednodu�en� a p�ehlednost pros�m vyu�ijte v grafu ozna�en�
typu KEY=X (pro o�ek�vanou kl�vesu) a KEY<>X (pro v�echny ostatn� p��pady).
  P�i n�vrhu respektujte rozhran� automatu (tj. n�zvy vstupn�ch a v�stupn�ch
sign�l�), kter� je p�ipraveno v souboru fsm.vhd. Rovn� zachovejte n�zev
prom�nn�ch automatu: present_state a next_state.
  Nezjednodu�ujte si pros�m pr�ci vlo�en�m p��stupov�ho k�du do prom�nn� typu
pole a jej�m cyklick�m testov�n�m. Takov�to projekty nebudou hodnoceny.
  P��klad automatu v souboru fsm.vhd slou�� pouze pro inspiraci a v ��dn�m
p��pad� nemus� souhlasit s V�mi navr�en�m automatem.
8. Navr�en� kone�n� automat implementujte v jazyce VHDL a ulo�te do
p�edp�ipraven�ho souboru fsm.vhd v adres��i fpga.
9. Prove�te simulaci VHDL k�du pomoc� programu ISIM. Simulaci lze spustit pomoc�
n�stroje qdevkit.
10. Jakmile je ov��ena funkce p��stupov�ho termin�lu v simulac�ch, je mo�n� p�istoupit k
testov�n� funkce p��mo na FITKitu. Nejprve prove�te p�eklad zdrojov�ch soubor� do
bin�rn� podoby (pomoc� n�stroje qdevkit).
11. Vytvo�en� bin�rn� soubor s p��ponou *.bin nahrajte do FPGA �ipu (pomoc� n�stroje
qdevkit).
12. Spr�vnou funkci p��stupov�ho termin�lu ov��te p��mo na FITKitu.
4. V�stupy projektu
V�stupem projektu bude:
1. Soubor fsm.vhd se zdrojov�m k�dem kone�n�ho automatu.
2. Soubor accterm.bin, obsahuj�c� konfiguraci pro FPGA �ip. Tento soubor naleznete
v podadres��i build.
3. Soubor zprava.pdf s v�stupn� zpr�vou (ve form�tu PDF) obsahuj�c� n�sleduj�c�
informace:
  Jm�no a p��jmen�, login, p��stupov� k�dy
  Graf p�echodu kone�n�ho automatu
  Seznam v�stup� s identifikac�, zda se jedn� o Mealyho nebo Moorovy v�stupy.
  Uk�zku v�stupn� zpr�vy naleznete v p��loze �. 1.
Rozsah zpr�vy nesm� p�ekro�it jednu stranu form�tu A4.
V�echny t�i soubory zabalte do arch�vu s n�zvem <login>.zip.
P�ed odevzd�n�m tohoto archivu do informa�n�ho syst�mu si pros�m tento archiv
otestujte skrze sadu testovac�ch skript� dostupn�ch v informa�n�m syst�mu v souboru
student_test.zip. Podrobn� n�vod na otestov�n� naleznete v p�ilo�en�m README
souboru.
Otestovan� archiv odevzdejte prost�ednictv�m informa�n�ho syst�mu nejpozd�ji do data
uveden�ho na wiki str�nk�ch p�edm�tu INC. Pozd�j�� odevzd�n� projektu nebude br�no
v �vahu.
Po zku�enostech z minul�ch let je�t� jedno d�le�it� upozorn�n�!
Podle Sm�rnice d�kana FIT dopl�uj�c� Studijn� a zku�ebn� ��d VUT (Rozhodnut�
d�kana FIT �. 34/2010), K �l�nku 11, odst. 4:
�Ve�ker� testy, projekty a dal�� hodnocen� �lohy vypracov�v� student samostatn�, pokud
projekt nebo �loha nebyly v�slovn� zad�ny pro stanovenou skupinu student�.�
V p��pad� odhalen� plagi�torstv� nebo nedovolen� spolupr�ce na projektu, bude proto
student odm�n�n neud�len�m z�po�tu z p�edm�tu INC (0 bod� za projekt). P��padn� i
p�edvol�n�m p�ed disciplin�rn� komisi podle Disciplin�rn�ho ��du pro studenty Fakulty
informa�n�ch technologi� Vysok�ho u�en� technick�ho v Brn�.
P��loha �. 1: Uk�zka v�stupn� zpr�vy
Jm�no:
Login:
P��stupov� k�dy:
Vstupn�/v�stupn� sign�ly
Legenda vstupn�ch sign�l�:
  K : KEY
  CO : CNT_OF
Identifikace v�stupn�ch sign�l�
  Mealyho v�stupy: A,B,C
  Moorovy v�stupy: X,Y,Z
Graf p�echod� (uk�zka)
Pozn�mka: Za v�stupn� sign�ly ABC a XYZ dosa�te do grafu p��mo hodnoty 0, 1 nebo X (don't care)
S2/XYZ
S1/XYZ
S3/XYZ
K=6/ABC
K<>6/ABC