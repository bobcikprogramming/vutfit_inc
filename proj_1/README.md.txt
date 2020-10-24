Projekt: Pøístupovı terminál
1. Zadání
1. Seznamte se s pøípravkem FITKit a zpùsobem pøipojení jeho periférií, zejména
klávesnice a LCD displeje.
2. Prostudujte si zdrojové kódy projektu v jazyce VHDL.
3. Navrhnìte øídicí jednotku (koneènı automat) jednoduchého pøístupového terminálu.
4. Navrenou øídicí jednotku implementujte v jazyce VHDL a ovìøte její funkènost
pøímo na pøípravku FITKit.
2. Architektura pøístupového terminálu
Pøístupovı terminál je jednoduché elektronické zaøízení, které povoluje oprávnìnım
uivatelùm vstup do chránìnıch objektù. Obvykle je sloeno z klávesnice, LCD displeje a
øídicí jednotky. Kadı uivatel musí pøed vstupem do objektu vyukat na klávesnici
pøístupového terminálu aktivaèní kód a na jeho základì získá nebo nezíská pøístup do objektu.
Cílem tohoto projektu je realizovat takovıto pøístupovı terminál na pøípravku FITKit, kde je
k dispozici klávesnice, LCD display a FPGA hradlové pole pøipojené k obìma tìmto
perifériím. Úlohou FPGA èipu bude sledovat vstupy klávesnice, vyhodnocovat zadanı
vstupní kód a vypisovat pøíslušné odezvy na LCD displeji. Architektura FPGA èipu je
uvedena na následujícím obrázku.
Obrázek 1. Architektura aplikace uvnitø FPGA
Funkce obvodu je následující:
? Vstupy z klávesnice jsou pravidelnì testovány pomocí øadièe klávesnice (Keyboard
Controller). Jakmile je detekován stisk nìkteré klávesy, nastaví øadiè na svém vıstupu
KEY jeden z 16-ti signálù odpovídající èíslu stisknuté klávesy (signály KEY(0..9)
odpovídají klávesám 0..9, signály KEY(10..13) odpovídají klávesám A..D, signál
KEY(14) odpovídá klávese "*", signál KEY(15) odpovídá klávese "#").
  Vıstupní signály z klávesnice jsou dále pøipojeny ke koneènému automatu (FSM),
kterı ovládá zbıvající èásti obvodu. Automat sleduje posloupnost stisknutıch kláves,
v prùbìhu zadávání kódu vypisuje na LCD displeji znak "*" a po potvrzení kódu
klávesou "#" vypíše na displej zprávu "Pristup povolen" nebo "Pristup odepren".
Opìtovnım stisknutím klávesy "#" pøechází obvod opìt do stavu èekajícího na vstupní
kód.
  Textové zprávy "Pristup povolen" resp. "Pristup odepren" jsou uloeny ve dvou
pamìovıch modulech typu ROM. Kadı z modulù obsahuje 16 osmi-bitovıch
poloek obsahujících jednu ze zpráv.
  V okamiku potvrzení vstupního kódu klávesou "#", aktivuje automat Clock Enable
signál 4-bitového èítaèe (COUNTER), kterı je pøipojen na adresové vstupy
pamìovıch modulù a zpùsobí tak vyètení jejich obsahu na vıstup.
  Vıstupy pamìovıch modulù jsou dále pøipojeny na dvou-vstupı multiplexor
(MX_MEM). V pøípadì, e byl kód správnì zadán, potom automat vybere skrze tento
multiplexor zprávu "Pøístup povolen", v opaèném pøípadì vybere zprávu "Pristup
odepren".
  Vıstup multiplexoru (MX_MEM) je pøipojen na další dvou-vstupı multiplexor
(MX_LCD). Tento multiplexor pøepíná na svùj vıstup buï zprávu uloenou v
pamìovıch modulech nebo znak "*" podle toho, zda se pøístupovı terminál nachází
ve stavu zadávání kódu nebo ve stavu vypisujícím vıstupní zprávu.
  Vıstup multiplexoru (MX_LCD) je pøipojen na datovı vstup øadièe LCD displeje
(LCD DISPLAY CONTROLLER) a reprezentuje znaky, které se budou zobrazovat na
displeji. Øadiè je ovládán pomocí dvou signálù WRITE a CLEAR. Aktivace signálu
WRITE zpùsobí zápis znaku na displeji, zatímco aktivace signálu CLEAR displej
vymae a pøipraví na zápis nové sekvence znakù.
Architektura FPGA èipu je pøipravena tak, e vše kromì koneèného automatu FSM je
ji naimplementováno v jazyce VHDL. Cílem toho projektu je proto správnì navrhnout
a implementovat právì tento automat øídící zbıvající èásti obvodu.
3. Postup práce
1. Pro vypracování projektu a jeho ovìøení na pøípravku FITkit jsou potøeba následující
nástroje: MSPGCC (kompilátor zdrojovıch souboru pro mikrokontrolér MSP430),
Xilinx ISE (vıvojové prostøedí pro syntézu obvodù v jazyce VHDL do èipu FPGA) a
QDevKit (prostøedí pro práci s pøípravkem FITkit). S ohledem na nároènost instalace
všech tìchto nástrojù byl pro Vás pøipraven obraz virtuálního stroje, kde jsou všechny
tyto nástroje ji nainstalovány. Obraz tohoto virtuálního stroje si stáhnìte z privátních
stránek FITkitu. Pro spuštìní tohoto stroje si nainstalujte volnì dostupnı program
VirtualBox.
2. Pøipojte FITkit k poèítaèi.
3. Spuste program VirtualBox a pøipojte obraz virtuálního stroje. V nastavení USB
zaøízení povolte FTDI Dual RS232 (viz obrázek) a virtuální stroj spuste.
Dùleitá poznámka: Pouívejte VirualBox verze 5 a vyšší. Starší verze nepodporují
USB 3.0, a proto pokud máte na svém poèítaèi pouze porty USB 3.0, potom se FITkit
nebude korektnì propagovat z vašeho systému a do virtuálního stroje.
4. Z informaèního systému si stáhnìte archív zdrojovıch souborù projekt.zip a rozbalte si
jej do adresáøe C:\FitkitSVN\apps\demo\terminal\ (uvnitø virtuálního stroje).
Po spuštìní aplikace QDevKit by se Vám mìla objevit v záloce Demo aplikace nová
poloka s názvem Pøístupovı terminál (viz obrázek). Od tohoto okamiku mùete
aplikaci pøekládat, simulovat, nahrávat do pøípravku FITkit a následnì spouštìt
(všechny tyto volby jsou dostupné skrze kontextové menu vyvolané kliknutím pravého
tlaèítka myši na poloku Pøístupovı terminál).
5. V informaèním systému také naleznete soubor kod.txt se seznamem pøístupovıch
kódù. Uvnitø tohoto souboru vyhledejte svùj login a u nìj naleznete také dva
pøístupové kódy pro Váš projekt.
6. Prostudujte si zdrojové kódy projektu v jazyce VHDL a zpùsob zapojení jeho
jednotlivıch èástí.
7. Navrhnìte øídicí jednotku (koneènı automat) jednoduchého pøístupového terminálu.
Pøi návrhu dbejte na následující poadavky:
  Pøístupovı terminál musí akceptovat pouze Vaše dva pøístupové kódy (tzn.
terminál vypíše hlášení „Pristup povolen“, pokud uivatel zadá správnì libovolnı z
obou kódù).
  Pokud uivatel v prùbìhu zadávání kódu stiskne špatnou klávesu, nesmí to Váš
automat nijak dát najevo, dokud není stisknuta potvrzovací klávesa "#".
  Identifikujte Mealyho a Moorovy vıstupy.
  Sestavte si graf pøechodù automatu.
  Pøi sestavování grafu pøechodu automatu vzniká obecnì velké mnoství pøechodù
mezi stavy, nebo je potøeba reagovat na všechny moné stisknuté klávesy (celkem
16 moností). Pro zjednodušení a pøehlednost prosím vyuijte v grafu oznaèení
typu KEY=X (pro oèekávanou klávesu) a KEY<>X (pro všechny ostatní pøípady).
  Pøi návrhu respektujte rozhraní automatu (tj. názvy vstupních a vıstupních
signálù), které je pøipraveno v souboru fsm.vhd. Rovnì zachovejte název
promìnnıch automatu: present_state a next_state.
  Nezjednodušujte si prosím práci vloením pøístupového kódu do promìnné typu
pole a jejím cyklickım testováním. Takovéto projekty nebudou hodnoceny.
  Pøíklad automatu v souboru fsm.vhd slouí pouze pro inspiraci a v ádném
pøípadì nemusí souhlasit s Vámi navrenım automatem.
8. Navrenı koneènı automat implementujte v jazyce VHDL a ulote do
pøedpøipraveného souboru fsm.vhd v adresáøi fpga.
9. Proveïte simulaci VHDL kódu pomocí programu ISIM. Simulaci lze spustit pomocí
nástroje qdevkit.
10. Jakmile je ovìøena funkce pøístupového terminálu v simulacích, je moné pøistoupit k
testování funkce pøímo na FITKitu. Nejprve proveïte pøeklad zdrojovıch souborù do
binární podoby (pomocí nástroje qdevkit).
11. Vytvoøenı binární soubor s pøíponou *.bin nahrajte do FPGA èipu (pomocí nástroje
qdevkit).
12. Správnou funkci pøístupového terminálu ovìøte pøímo na FITKitu.
4. Vıstupy projektu
Vıstupem projektu bude:
1. Soubor fsm.vhd se zdrojovım kódem koneèného automatu.
2. Soubor accterm.bin, obsahující konfiguraci pro FPGA èip. Tento soubor naleznete
v podadresáøi build.
3. Soubor zprava.pdf s vıstupní zprávou (ve formátu PDF) obsahující následující
informace:
  Jméno a pøíjmení, login, pøístupové kódy
  Graf pøechodu koneèného automatu
  Seznam vıstupù s identifikací, zda se jedná o Mealyho nebo Moorovy vıstupy.
  Ukázku vıstupní zprávy naleznete v pøíloze è. 1.
Rozsah zprávy nesmí pøekroèit jednu stranu formátu A4.
Všechny tøi soubory zabalte do archívu s názvem <login>.zip.
Pøed odevzdáním tohoto archivu do informaèního systému si prosím tento archiv
otestujte skrze sadu testovacích skriptù dostupnıch v informaèním systému v souboru
student_test.zip. Podrobnı návod na otestování naleznete v pøiloeném README
souboru.
Otestovanı archiv odevzdejte prostøednictvím informaèního systému nejpozdìji do data
uvedeného na wiki stránkách pøedmìtu INC. Pozdìjší odevzdání projektu nebude bráno
v úvahu.
Po zkušenostech z minulıch let ještì jedno dùleité upozornìní!
Podle Smìrnice dìkana FIT doplòující Studijní a zkušební øád VUT (Rozhodnutí
dìkana FIT è. 34/2010), K èlánku 11, odst. 4:
„Veškeré testy, projekty a další hodnocené úlohy vypracovává student samostatnì, pokud
projekt nebo úloha nebyly vıslovnì zadány pro stanovenou skupinu studentù.“
V pøípadì odhalení plagiátorství nebo nedovolené spolupráce na projektu, bude proto
student odmìnìn neudìlením zápoètu z pøedmìtu INC (0 bodù za projekt). Pøípadnì i
pøedvoláním pøed disciplinární komisi podle Disciplinárního øádu pro studenty Fakulty
informaèních technologií Vysokého uèení technického v Brnì.
Pøíloha è. 1: Ukázka vıstupní zprávy
Jméno:
Login:
Pøístupové kódy:
Vstupní/vıstupní signály
Legenda vstupních signálù:
  K : KEY
  CO : CNT_OF
Identifikace vıstupních signálù
  Mealyho vıstupy: A,B,C
  Moorovy vıstupy: X,Y,Z
Graf pøechodù (ukázka)
Poznámka: Za vıstupní signály ABC a XYZ dosaïte do grafu pøímo hodnoty 0, 1 nebo X (don't care)
S2/XYZ
S1/XYZ
S3/XYZ
K=6/ABC
K<>6/ABC