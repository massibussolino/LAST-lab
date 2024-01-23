# LAST-lab

Contenuto:

* ```Environment.m``` è la funzione principale che deve essere esguita per 
ottenere i plot di ingombro e raggiungibilità del braccio robotico NS12 18.5

* ```Disposzione_nn.yml``` sono file usati per definire le posizioni degli 
elementi della stanza (le due tende, il diorama, il pavimento e il braccio).
Il sistema di riferimento usato per definirli è cartesiano centrato nell'angolo
delle due tende. Di ogni elemento (a meno del braccio) deve essere specificata
la dimensione in mm espressa in coordinate della stanza, e la poszione del
vertice in basso a sinistra di ogni elemento. Del braccio devono essere 
specificate la posizione e la rotazione azimuthale rispetto all'asse x della stanza.

* ```RoomLayoutStl.m``` script matlab per la rappresentazione della posizione
e degli ingombri del braccio rispetto al file stl della stanza con incluse le 
gabbie. In questo caso gli assi sono centrati nell'angolo in basso a destra della
stanza e non delle tende (non presenti nei file stl).

